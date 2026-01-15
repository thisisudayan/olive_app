import 'package:olive_app/core/services/supabase_service.dart';
import 'package:olive_app/data/local/auth_local_datasource.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:olive_app/data/remote/stores_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseService _supabaseService = SupabaseService();
  final AuthLocalDataSource _localDataSource = AuthLocalDataSource();
  final StoresApi _storesApi = StoresApi();

  Stream<AuthState> get onAuthStateChange =>
      _supabaseService.client.auth.onAuthStateChange;

  Future<void> signInWithGoogle() async {
    await _supabaseService.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'appcommerz://login-callback',
    );
  }

  Future<void> signInWithGithub() async {
    await _supabaseService.auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: 'appcommerz://login-callback',
    );
  }

  Future<void> logout() async {
    try {
      await _supabaseService.auth.signOut();
      await _localDataSource.clearAuth();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StoreModel>> fetchStores() async {
    return await _storesApi.fetchStores();
  }

  AuthLocalDataSource get localDataSource => _localDataSource;
}
