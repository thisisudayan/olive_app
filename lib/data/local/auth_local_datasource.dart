import 'package:olive_app/core/sembast/sembast_db.dart';
import 'package:olive_app/data/models/auth_state.dart';
import 'package:olive_app/data/models/merchant_model.dart';
import 'package:sembast/sembast.dart';

class AuthLocalDataSource {
  static const String storeName = 'auth';
  final _store = stringMapStoreFactory.store(storeName);
  static const String _authKey = 'auth_state';

  /// Save the entire auth state
  Future<void> saveAuthState(AuthState state) async {
    final db = await SembastDb.instance.database;
    await _store.record(_authKey).put(db, state.toJson());
  }

  /// Get the current auth state
  Future<AuthState?> getAuthState() async {
    final db = await SembastDb.instance.database;
    final data = await _store.record(_authKey).get(db);
    if (data == null) return null;
    return AuthState.fromJson(Map<String, dynamic>.from(data));
  }

  /// Update merchant info
  Future<void> updateMerchant(MerchantModel merchant) async {
    final state = await getAuthState() ?? AuthState();
    await saveAuthState(state.copyWith(merchant: merchant));
  }

  /// Update selected store
  Future<void> selectStoreById(int storeId) async {
    final state = await getAuthState();
    if (state == null) return;

    final selected = state.allStores.firstWhere(
      (s) => s.id == storeId,
      orElse: () => throw Exception('Store not found'),
    );

    await saveAuthState(state.copyWith(selectedStore: selected));
  }

  /// Clear session but keep store list if needed, or clear everything
  Future<void> clearAuth() async {
    final db = await SembastDb.instance.database;
    await _store.record(_authKey).delete(db);
  }

  /// Clear only merchant info
  Future<void> clearMerchant() async {
    final state = await getAuthState();
    if (state == null) return;
    await saveAuthState(
      AuthState(
        merchant: null,
        selectedStore: state.selectedStore,
        allStores: state.allStores,
      ),
    );
  }

  /// Clear selected store
  Future<void> clearSelectedStore() async {
    final state = await getAuthState();
    if (state == null) return;
    await saveAuthState(state.copyWith(clearSelectedStore: true));
  }

  /// Watch auth state changes
  Stream<AuthState?> watchAuthState() async* {
    final db = await SembastDb.instance.database;
    yield* _store.record(_authKey).onSnapshot(db).map((snapshot) {
      if (snapshot == null) return null;
      return AuthState.fromJson(Map<String, dynamic>.from(snapshot.value));
    });
  }

  /// Check if fully authorized
  Future<bool> isAuthorized() async {
    final state = await getAuthState();
    return state?.merchant != null && state?.selectedStore != null;
  }
}
