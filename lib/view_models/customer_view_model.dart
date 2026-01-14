import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/data/repositories/customer_repository.dart';

class CustomerViewModel extends ChangeNotifier {
  final CustomerRepository _repository = CustomerRepository();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  bool _isLoading = false;
  bool _isOnline = true;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isOnline => _isOnline;
  String? get errorMessage => _errorMessage;

  CustomerViewModel() {
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (results.isNotEmpty) {
        _updateConnectionStatus(results);
      }
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _isOnline = results.any((result) => result != ConnectivityResult.none);
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Stream<List<CustomerModel>> watchCustomers() {
    return _repository.watchCustomers();
  }

  Future<void> syncData() async {
    if (!_isOnline) {
      _errorMessage = "No internet connection.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.refreshCustomers();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // If we have local data already, don't show an error just because the sync failed
      final localData = await _repository.getCustomers();
      _isLoading = false;
      if (localData.isEmpty) {
        _errorMessage =
            "Failed to load customers. Please check your connection.";
      }
      notifyListeners();
    }
  }
}
 