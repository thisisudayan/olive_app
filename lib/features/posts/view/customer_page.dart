import 'package:flutter/material.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/data/repositories/customer_repository.dart';
import 'package:olive_app/features/posts/view/widgets/olive_list_tile.dart';
import 'package:olive_app/main.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomersTab extends StatefulWidget {
  const CustomersTab({super.key});

  @override
  State<CustomersTab> createState() => _CustomersTabState();
}

class _CustomersTabState extends State<CustomersTab> {
  final CustomerRepository _repository = CustomerRepository();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _syncData();
  }

  Future<void> _syncData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _repository.refreshCustomers();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        // If we have local data already, don't show an error just because the sync failed
        final localData = await _repository.getCustomers();
        setState(() {
          _isLoading = false;
          if (localData.isEmpty) {
            _errorMessage =
                "Failed to load customers. Please check your connection.";
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 160.0,
            actions: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                      color: Colors.black,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Icon(Icons.cloud_download, size: 20, color: Colors.blue),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0, 0.5), // bottom → top
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  _isLoading ? "Loading..." : "Customers",
                  key: ValueKey(_isLoading ? "loading" : "customers"),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              centerTitle: true,
              background: Image.asset(
                "assets/customer_cover.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: StreamBuilder<List<CustomerModel>>(
          stream: _repository.watchCustomers(),
          builder: (context, snapshot) {
            if (_errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _syncData,
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            final customers = snapshot.data ?? [];

            if (_isLoading && customers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (customers.isEmpty) {
              return const Center(child: Text("No customers found."));
            }

            return GenericListView<CustomerModel>(
              items: customers,
              itemBuilder: (context, item) => OliveListTile(
                title: item.name,
                subtitle: item.email ?? item.phone ?? "No contact info",
                imageUrl: item.avatar,
                badgeText: item.status.toUpperCase(),
                badgeColor: item.status == 'active'
                    ? Colors.green
                    : Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
