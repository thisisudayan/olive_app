import 'package:olive_app/core/sembast/sembast_db.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:sembast/sembast.dart';

class StoreLocalDataSource {
  static const String storeName = 'stores';
  final _store = intMapStoreFactory.store(storeName);

  Future<Database> get _db async => await SembastDb.instance.database;

  Future<void> saveStores(List<StoreModel> stores, {bool clear = false}) async {
    final database = await _db;
    await database.transaction((txn) async {
      if (clear) {
        await _store.delete(txn);
      }
      for (var store in stores) {
        await _store.record(store.id).put(txn, store.toJson());
      }
    });
  }

  Future<List<StoreModel>> getStores() async {
    final recordSnapshots = await _store.find(await _db);
    return recordSnapshots.map((snapshot) {
      return StoreModel.fromJson(snapshot.value);
    }).toList();
  }

  Stream<List<StoreModel>> watchStores() async* {
    final database = await _db;
    final query = _store.query();
    yield* query.onSnapshots(database).map((snapshots) {
      return snapshots.map((snapshot) {
        return StoreModel.fromJson(snapshot.value);
      }).toList();
    });
  }

  Future<void> clearStores() async {
    final database = await _db;
    await _store.delete(database);
  }
}
