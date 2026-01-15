import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:olive_app/core/services/connectivity_service.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/data/repositories/customer_repository.dart';

class CustomerViewModel extends ChangeNotifier {
  final CustomerRepository _repository = CustomerRepository();
  final ConnectivityService _connectivityService = ConnectivityService();
  StreamSubscription? _connectivitySubscription;

  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _isOnline = true;
  String? _errorMessage;
  int _currentPage = 1;
  bool _hasMore = true;

  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get isOnline => _isOnline;
  String? get errorMessage => _errorMessage;

  CustomerViewModel() {
    _initConnectivity();
  }

  void _initConnectivity() {
    _isOnline = _connectivityService.isOnline;
    _connectivitySubscription = _connectivityService.onConnectivityChanged
        .listen((isOnline) {
          _isOnline = isOnline;
          notifyListeners();
        });
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
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();

    try {
      final response = await _repository.refreshCustomers(page: _currentPage);
      _hasMore =
          (response.pagination?.page ?? 0) < (response.pagination?.pages ?? 0);
      _isLoading = false;
      _errorMessage = null;
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

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || !_isOnline) return;

    _isLoadingMore = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.loadMoreCustomers(
        page: _currentPage + 1,
      );
      _currentPage++;
      _hasMore =
          (response.pagination?.page ?? 0) < (response.pagination?.pages ?? 0);
      _isLoadingMore = false;
      notifyListeners();
    } catch (e) {
      _isLoadingMore = false;
      _errorMessage = "Failed to load more customers.";
      notifyListeners();
    }
  }
}
