import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:olive_app/core/services/connectivity_service.dart';
import 'package:olive_app/data/models/product_model.dart';
import 'package:olive_app/data/repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
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

  ProductViewModel() {
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

 
  Stream<List<ProductModel>> watchProducts() {
    return _repository.watchProducts();
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
      final response = await _repository.refreshProducts(page: _currentPage);

      _hasMore =
          (response.pagination?.page ?? 0) < (response.pagination?.pages ?? 0);
      _isLoading = false;
      _errorMessage = null;

      debugPrint("hasMore: $_hasMore");
      debugPrint("currentPage: $_currentPage");
      debugPrint("products:${response.data}");
      notifyListeners();
    } catch (e) {
      final localData = await _repository.getProducts();
      _isLoading = false;
      if (localData.isEmpty) {
        _errorMessage =
            "Failed to load products. Please check your internet connection.";
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
      final products = await _repository.loadMoreProducts(
        page: _currentPage + 1,
      );

      _currentPage++;
      _hasMore =
          (products.pagination?.page ?? 0) < (products.pagination?.pages ?? 0);

      _isLoadingMore = false;
      notifyListeners();
    } catch (e) {
      _isLoadingMore = false;
      _errorMessage = "Failed to load more products.";
      notifyListeners();
    }
  }
}
