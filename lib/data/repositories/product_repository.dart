import 'package:olive_app/data/local/product_local_datasource.dart';
import 'package:olive_app/data/models/product_model.dart';
import 'package:olive_app/data/remote/product_api.dart';

class ProductRepository {
  final ProductApi _api = ProductApi();
  final ProductLocalDatasource _localDataSource = ProductLocalDatasource();

  Stream<List<ProductModel>> watchProducts() {
    return _localDataSource.watchProducts();
  }

  Future<ProductResponseModel> refreshProducts({
    int page = 1,
    int limit = 10,
    bool clear = true,
  }) async {
    try {
      final response = await _api.fetchProducts(page: page, limit: limit);
      await _localDataSource.saveProducts(response.data, clear: clear);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductResponseModel> loadMoreProducts({
    required int page,
    int limit = 10,
  }) async {
    return refreshProducts(page: page, limit: limit, clear: false);
  }

  Future<List<ProductModel>> getProducts() async {
    return _localDataSource.getProducts();
  }
}
