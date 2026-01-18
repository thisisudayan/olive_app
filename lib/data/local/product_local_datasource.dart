import 'package:olive_app/core/sembast/sembast_db.dart';
import 'package:olive_app/data/models/product_model.dart';
import 'package:sembast/sembast.dart';

class ProductLocalDatasource {
  static const String storeName = 'products';
  final _store = intMapStoreFactory.store(storeName);

  Future<Database> get _db async => await SembastDb.instance.database;

  Future<void> saveProducts(
    List<ProductModel> products, {
    bool clear = false,
  }) async {
    final database = await _db;
    await database.transaction((txn) async {
      if (clear) {
        await _store.delete(txn);
      }
      for (var product in products) {
        await _store.record(product.id).put(txn, product.toJson());
      }
    });
  }

  Future<List<ProductModel>> getProducts() async {
    final recordSnapshots = await _store.find(await _db);
    return recordSnapshots.map((snapshot) {
      return ProductModel.fromJson(snapshot.value);
    }).toList();
  }

  Stream<List<ProductModel>> watchProducts() async* {
    final database = await _db;
    final query = _store.query();
    yield* query.onSnapshots(database).map((snapshots) {
      return snapshots.map((snapshot) {
        return ProductModel.fromJson(snapshot.value);
      }).toList();
    });
  }
}
