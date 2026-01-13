import 'package:olive_app/core/sembast/sembast_db.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:sembast/sembast.dart';

class CustomerLocalDataSource {
  static const String storeName = 'customers';
  final _store = intMapStoreFactory.store(storeName);

  Future<Database> get _db async => await SembastDb.instance.database;

  Future<void> saveCustomers(List<CustomerModel> customers) async {
    final database = await _db;
    await database.transaction((txn) async {
      // Clear existing customers for simplicity in this example
      await _store.delete(txn);
      for (var customer in customers) {
        await _store.add(txn, customer.toJson());
      }
    });
  }

  Future<List<CustomerModel>> getCustomers() async {
    final recordSnapshots = await _store.find(await _db);
    return recordSnapshots.map((snapshot) {
      return CustomerModel.fromJson(snapshot.value);
    }).toList();
  }

  Stream<List<CustomerModel>> watchCustomers() async* {
    final database = await _db;
    final query = _store.query();
    yield* query.onSnapshots(database).map((snapshots) {
      return snapshots.map((snapshot) {
        return CustomerModel.fromJson(snapshot.value);
      }).toList();
    });
  }
}
