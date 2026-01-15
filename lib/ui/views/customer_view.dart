import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/ui/widgets/empty_data.dart';
import 'package:olive_app/ui/widgets/error.dart';
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
                final customers = snapshot.data ?? [];
                if (_viewModel.errorMessage != null && customers.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ErrorView(
                        title: "Ooops!",
                        description:
                            "We hit a snag. Refresh or come back shortly.",
                        onRetry: _viewModel.syncData,
                        retryText: "Refresh",
                        maxWidth: 220,
                      ),
                    ),
                  );
                }

                if (_viewModel.isLoading && customers.isEmpty) {
                  return EmptyData(
                    title: "Customers Await",
                    description:
                        "Start by acquiring a customer to see your list come alive.",
                    image: "assets/no_customer.png",
                    maxWidth: 220,
                    retryText: "Refresh",
                    onRetry: _viewModel.syncData,
                  );
                }

                if (customers.isEmpty) {
                  return EmptyData(
                    title: "Customers Await",
                    description:
                        "Start by acquiring a customer to see your list come alive.",
                    image: "assets/no_customer.png",
                    maxWidth: 220,
                    retryText: "Refresh",
                    onRetry: _viewModel.syncData,
                  );
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
                      endActions: [
                        SlidableAction(
                          onPressed: (context) {
                            // toggle status
                            // call api
                            // update ui
                          },
                          backgroundColor: item.status == "active"
                              ? Colors.red
                              : Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icon(LucideIcons.circleSlash).icon,
                          label: item.status == "active" ? "Ban" : "Unban",
                        ),
                      ],
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
