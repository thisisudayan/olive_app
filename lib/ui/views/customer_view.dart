import 'package:flutter/material.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/ui/widgets/empty_data.dart';
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
                      child: EmptyData(
                        title: "Ooops!",
                        description:
                            "It seems there is something wrong with your internet connection. Please connect to the internet and start APCOMMERZ again.",
                        onRetry: _viewModel.syncData,
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

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 200) {
                      _viewModel.loadMore();
                    }
                    return true;
                  },
                  child: GenericListView<CustomerModel>(
                    items: customers,
                    itemBuilder: (context, item) => OliveListTile(
                      title: item.name,
                      subtitle: item.email ?? item.phone ?? "No contact info",
                      imageUrls: item.avatar != null ? [item.avatar!] : [],
                      badgeText: item.status,
                    ),
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
