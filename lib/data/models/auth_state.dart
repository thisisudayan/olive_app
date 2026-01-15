import 'merchant_model.dart';
import 'store_model.dart';

class AuthState {
  final MerchantModel? merchant;
  final StoreModel? selectedStore;
  final List<StoreModel> allStores;

  AuthState({this.merchant, this.selectedStore, this.allStores = const []});

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      merchant: json['merchant'] != null
          ? MerchantModel.fromJson(json['merchant'])
          : null,
      selectedStore: json['selected_store'] != null
          ? StoreModel.fromJson(json['selected_store'])
          : null,
      allStores:
          (json['all_stores'] as List?)
              ?.map((e) => StoreModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchant': merchant?.toJson(),
      'selected_store': selectedStore?.toJson(),
      'all_stores': allStores.map((e) => e.toJson()).toList(),
    };
  }

  AuthState copyWith({
    MerchantModel? merchant,
    StoreModel? selectedStore,
    List<StoreModel>? allStores,
    bool clearSelectedStore = false,
  }) {
    return AuthState(
      merchant: merchant ?? this.merchant,
      selectedStore: clearSelectedStore
          ? null
          : (selectedStore ?? this.selectedStore),
      allStores: allStores ?? this.allStores,
    );
  }
}
