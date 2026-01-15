import 'package:flutter/foundation.dart';
import 'package:olive_app/data/local/store_local_datasource.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:olive_app/data/remote/stores_api.dart';

class StoreRepository {
  final StoresApi _api = StoresApi();
  final StoreLocalDataSource _localDataSource = StoreLocalDataSource();

  Stream<List<StoreModel>> watchStores() {
    return _localDataSource.watchStores();
  }

  Future<List<StoreModel>> refreshStores() async {
    try {
      debugPrint('🔄 StoreRepository.refreshStores() called');
      final stores = await _api.fetchStores();
      debugPrint('✅ StoresApi returned ${stores.length} stores');
      await _localDataSource.saveStores(stores, clear: true);
      debugPrint('💾 Stores saved to Sembast');
      return stores;
    } catch (e) {
      debugPrint('❌ StoreRepository.refreshStores() error: $e');
      rethrow;
    }
  }

  Future<List<StoreModel>> getStores() async {
    return _localDataSource.getStores();
  }

  Future<void> clearStores() async {
    await _localDataSource.clearStores();
  }
}
