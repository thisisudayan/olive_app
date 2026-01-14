import 'package:flutter/material.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/ui/widgets/network_exposer.dart';
import 'package:olive_app/ui/widgets/olive_list_tile.dart';
import 'package:olive_app/ui/widgets/generic_list_view.dart';
import 'package:olive_app/view_models/customer_view_model.dart';

class CustomersTab extends StatefulWidget {
  const CustomersTab({super.key});

  @override
  State<CustomersTab> createState() => _CustomersTabState();
}

class _CustomersTabState extends State<CustomersTab> {
  final CustomerViewModel _viewModel = CustomerViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.syncData();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                expandedHeight: 160.0,
                actions: [
                  NetworkExposer(
                    state: _viewModel.isLoading
                        ? NetworkState.loading
                        : NetworkState.upToDate,
                    onTap: _viewModel.syncData,
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    "Customers",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
              stream: _viewModel.watchCustomers(),
              builder: (context, snapshot) {
                if (_viewModel.errorMessage != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/network_error.png",
                            width: 160,
                            height: 160,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Ooops!",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF363C44),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "It seems there is something wrong with your internet connection. Please connect to the internet and start APCOMMERZ again.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 40,
                            child: OutlinedButton(
                              style: FilledButton.styleFrom(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: _viewModel.syncData,
                              child: const Text(
                                "TRY AGAIN",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final customers = snapshot.data ?? [];

                if (_viewModel.isLoading && customers.isEmpty) {
                  return const SizedBox.shrink();
                }

                if (customers.isEmpty) {
                  return const Center(child: Text("You have no customer"));
                }

                return GenericListView<CustomerModel>(
                  items: customers,
                  itemBuilder: (context, item) => OliveListTile(
                    title: item.name,
                    subtitle: item.email ?? item.phone ?? "No contact info",
                    imageUrls: [?item.avatar],
                    badgeText: item.status,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
