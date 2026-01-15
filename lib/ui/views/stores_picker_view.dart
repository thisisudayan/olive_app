import 'package:flutter/material.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:olive_app/data/repositories/store_repository.dart';

class StoresPickerView extends StatefulWidget {
  const StoresPickerView({super.key});

  @override
  State<StoresPickerView> createState() => _StoresPickerViewState();
}

class _StoresPickerViewState extends State<StoresPickerView> {
  final StoreRepository _repository = StoreRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Store'), centerTitle: true),
      body: StreamBuilder<List<StoreModel>>(
        stream: _repository.watchStores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final stores = snapshot.data ?? [];

          if (stores.isEmpty) {
            return const Center(child: Text('No stores available'));
          }

          return ListView.builder(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return ListTile(
                leading: CircleAvatar(child: Text(store.name[0].toUpperCase())),
                title: Text(store.name),
                subtitle: Text('${store.role.name} • ${store.status}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, store);
                },
              );
            },
          );
        },
      ),
    );
  }
}
