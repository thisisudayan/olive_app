import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olive_app/data/local/auth_local_datasource.dart';
import 'package:olive_app/data/repositories/store_repository.dart';
import 'package:olive_app/ui/widgets/oliver_badge.dart';
import 'package:olive_app/view_models/auth_view_model.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel viewModel = AuthViewModel();
    final StoreRepository storeRepository = StoreRepository();
    final AuthLocalDataSource authDataSource = AuthLocalDataSource();

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                expandedHeight: 160.0,
                leading: StreamBuilder(
                  stream: authDataSource.watchAuthState(),
                  builder: (context, snapshot) {
                    final avatar = snapshot.data?.merchant?.avatar;
                    if (avatar == null || avatar.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(child: Icon(Icons.person)),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(avatar),
                      ),
                    );
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: StreamBuilder(
                    stream: authDataSource.watchAuthState(),
                    builder: (context, snapshot) {
                      final merchantName =
                          snapshot.data?.merchant?.name ?? 'Settings';
                      return Text(
                        merchantName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                  centerTitle: true,
                  background: Image.asset(
                    'assets/customer_cover.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            body: StreamBuilder(
              stream: storeRepository.watchStores(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final stores = snapshot.data ?? [];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Stores Section
                      if (stores.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey.withAlpha(50),
                                  indent: 16,
                                ),
                                padding: EdgeInsets.zero,
                                itemCount: stores.length,
                                itemBuilder: (context, index) {
                                  final store = stores[index];
                                  final formattedDate = DateFormat(
                                    'dd MMM, yyyy',
                                  ).format(store.lastUpdate);

                                  return ListTile(
                                    splashColor: Colors.transparent,
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey.withAlpha(
                                        50,
                                      ),
                                      child: Text(
                                        store.name
                                            .substring(0, 2)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    title: Text(store.name),
                                    subtitle: Text(
                                      'Last update at $formattedDate',
                                    ),
                                    trailing: OliverBadge(
                                      badgeText:
                                          store.invitation?.status == 'pending'
                                          ? 'invited'
                                          : 'active',
                                    ),
                                    onTap: () {
                                      // Handle store selection
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                      // Logout Section
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.red),
                            ),
                            trailing: viewModel.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.red,
                                    ),
                                  )
                                : null,
                            onTap: viewModel.isLoading
                                ? null
                                : () async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Logout'),
                                        content: const Text(
                                          'Are you sure you want to logout?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('Logout'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmed == true) {
                                      await viewModel.logout();
                                    }
                                  },
                          ),
                        ),
                      ),
                    ],
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
