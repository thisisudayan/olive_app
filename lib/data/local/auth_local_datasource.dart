import 'package:olive_app/core/sembast/sembast_db.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:olive_app/data/models/user_model.dart';
import 'package:sembast/sembast.dart';

class AuthLocalDataSource {
  static const String storeName = 'auth';
  final _store = stringMapStoreFactory.store(storeName);

  Future<void> saveAuthState({
    required UserModel user,
    StoreModel? selectedStore,
    List<StoreModel>? allStores,
  }) async {
    final db = await SembastDb.instance.database;
    final authState = {
      'user': user.toJson(),
      'selected_store': selectedStore?.toJson(),
      'all_stores': allStores?.map((e) => e.toJson()).toList(),
    };
    await _store.record('auth_state').put(db, authState);
  }

  /// Get auth state
  Future<Map<String, dynamic>?> getAuthState() async {
    final db = await SembastDb.instance.database;
    final data = await _store.record('auth_state').get(db);
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  /// Get User
  Future<UserModel?> getUser() async {
    final auth = await getAuthState();
    if (auth == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(auth['user']));
  }

  //update user

  Future<void> updateUser(UserModel updatedUser) async {
    final db = await SembastDb.instance.database;
    final record = _store.record('auth_state');

    final data = await record.get(db);
    if (data == null) return;

    final auth = Map<String, dynamic>.from(data);

    auth['user'] = updatedUser.toJson();

    await record.put(db, auth);
  }

  /// Get Selected Store
  Future<StoreModel?> getSelectedStore() async {
    final auth = await getAuthState();
    if (auth == null) return null;
    final selected = auth['selected_store'];
    if (selected == null) return null;
    return StoreModel.fromJson(Map<String, dynamic>.from(selected));
  }

  /// Get All Stores
  Future<List<StoreModel>> getAllStores() async {
    final auth = await getAuthState();
    if (auth == null || auth['all_stores'] == null) return [];
    final list = List<Map<String, dynamic>>.from(auth['all_stores']);
    return list.map((e) => StoreModel.fromJson(e)).toList();
  }

  //select store by id(Store switching)

  Future<void> selectStoreById(int storeId) async {
    final db = await SembastDb.instance.database;
    final record = _store.record('auth_state');

    final data = await record.get(db);
    if (data == null) return;

    final auth = Map<String, dynamic>.from(data);

    final allStoresJson = auth['all_stores'];
    if (allStoresJson == null) return;

    final stores = (allStoresJson as List)
        .map((e) => StoreModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    final selected = stores.firstWhere(
      (s) => s.id == storeId,
      orElse: () => throw Exception('Store not found'),
    );

    auth['selected_store'] = selected.toJson();

    await record.put(db, auth);
  }

  /// Clear only user info
  Future<void> clearUser() async {
    final db = await SembastDb.instance.database;
    final record = _store.record('auth_state');
    final data = await record.get(db);
    if (data == null) return;

    final auth = Map<String, dynamic>.from(data);
    auth.remove('user');
    await record.put(db, auth);
  }

  /// Clear selected store
  Future<void> clearSelectedStore() async {
    final db = await SembastDb.instance.database;
    final record = _store.record('auth_state');
    final data = await record.get(db);
    if (data == null) return;

    final auth = Map<String, dynamic>.from(data);
    auth.remove('selected_store');
    await record.put(db, auth);
  }

  /// Clear all stores
  Future<void> clearStores() async {
    final db = await SembastDb.instance.database;
    final record = _store.record('auth_state');
    final data = await record.get(db);
    if (data == null) return;

    final auth = Map<String, dynamic>.from(data);
    auth.remove('all_stores');
    await record.put(db, auth);
  }

  //listener

  Stream<Map<String, dynamic>?> watchAuthState() async* {
    final db = await SembastDb.instance.database;
    final record = _store.record('auth_state');

    yield* record.onSnapshot(db).map((snapshot) {
      if (snapshot == null) return null;
      return Map<String, dynamic>.from(snapshot.value);
    });
  }

  //check if user and store exists
  Future<bool> hasUserAndStore() async {
    final auth = await getAuthState();
    if (auth == null) return false;
    return auth['user'] != null && auth['selected_store'] != null;
  }
}
