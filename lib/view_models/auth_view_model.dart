import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:olive_app/data/models/auth_state.dart' as local;
import 'package:olive_app/data/models/merchant_model.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:olive_app/data/repositories/auth_repository.dart';
import 'package:olive_app/data/repositories/store_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  final StoreRepository _storeRepository = StoreRepository();
  bool _isLoading = false;
  String? _error;
  StreamSubscription? _authSubscription;

  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthViewModel() {
    _setupAuthListener();
  }

  void _setupAuthListener() {
    _authSubscription = _repository.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;

      debugPrint('🔐 Auth event: $event');

      if (event == AuthChangeEvent.signedIn && session != null) {
        debugPrint('✅ User signed in, fetching stores...');
        final user = session.user;
        final merchant = MerchantModel(
          id: user.id,
          email: user.email ?? '',
          name: user.userMetadata?['name'],
          avatar: user.userMetadata?['avatar_url'],
        );

        // Fetch stores from API and save to sembast via StoreRepository
        List<StoreModel> stores = [];
        try {
          debugPrint('📡 Calling StoreRepository.refreshStores()...');
          stores = await _storeRepository.refreshStores();
          debugPrint('✅ Fetched ${stores.length} stores from API');
        } catch (e) {
          // Fallback or handle error (maybe use mock if API fails during dev)
          debugPrint("❌ Error fetching stores: $e");
          // Check if we have local stores
          stores = await _storeRepository.getStores();
          debugPrint('📦 Loaded ${stores.length} stores from local cache');

          if (stores.isEmpty) {
            debugPrint('⚠️ No stores found, using mock store');
            stores = [
              StoreModel(
                id: 1,
                name: "My First Store",
                role: RoleModel(id: 1, name: "Owner"),
                status: "active",
                lastUpdate: DateTime.now(),
              ),
            ];
          }
        }

        final authState = local.AuthState(
          merchant: merchant,
          selectedStore: stores.isNotEmpty ? stores.first : null,
          allStores: stores,
        );

        await _repository.localDataSource.saveAuthState(authState);
        debugPrint('💾 Auth state saved with ${stores.length} stores');
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      await _repository.signInWithGoogle();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGithub() async {
    _setLoading(true);
    try {
      await _repository.signInWithGithub();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await _repository.logout();
      await _storeRepository.clearStores();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
