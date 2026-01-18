

class ProductResponseModel {
 
 
  final List<ProductModel> data;
  final PaginationModel? pagination;

  ProductResponseModel({
 
  
    required this.data,
    this.pagination,
 
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
    
      
      data: (json['data'] as List? ?? [])
          .map((i) => ProductModel.fromJson(i))
          .toList(),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
    
     
      'data': data.map((i) => i.toJson()).toList(),
      'pagination': pagination?.toJson(),
     
    };
  }
}

class ProductModel {
  final int id;
  final int storeId;
  final String title;
  final String handle;
  final String description;
  final String vendor;
  final String? productType;
  final String status;
  final bool isPhysicalProduct;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductDetails? details;
  final List<ProductVariant> variants;
  final List<ProductOption> options;
  final List<ProductMedia> media;
  final PaginationModel? pagination;

  ProductModel({
    required this.id,
    required this.storeId,
    required this.title,
    required this.handle,
    required this.description,
    required this.vendor,
    this.productType,
    required this.status,
    required this.isPhysicalProduct,
    required this.createdAt,
    required this.updatedAt,
    this.details,
    required this.variants,
    required this.options,
    required this.media,
    this.pagination,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      storeId: json['store_id'],
      title: json['title'],
      handle: json['handle'],
      description: json['description'] ?? '',
      vendor: json['vendor'] ?? '',
      productType: json['product_type'],
      status: json['status'] ?? '',
      isPhysicalProduct: json['is_physical_product'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      details: json['details'] != null
          ? ProductDetails.fromJson(json['details'])
          : null,
      variants: (json['variants'] as List? ?? [])
          .map((e) => ProductVariant.fromJson(e))
          .toList(),
      options: (json['options'] as List? ?? [])
          .map((e) => ProductOption.fromJson(e))
          .toList(),
      media: (json['media'] as List? ?? [])
          .map((e) => ProductMedia.fromJson(e))
          .toList(),
          pagination: json['pagination'] != null
              ? PaginationModel.fromJson(json['pagination'])
              : null,
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'title': title,
      'handle': handle,
      'description': description,
      'vendor': vendor,
      'product_type': productType,
      'status': status,
      'is_physical_product': isPhysicalProduct,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'details': details?.toJson(),
      'variants': variants.map((e) => e.toJson()).toList(),
      'options': options.map((e) => e.toJson()).toList(),
      'media': media.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class ProductDetails {
  final int id;
  final int price;
  final int? compareAtPrice;
  final bool trackInventory;
  final int totalStock;
  final double? weightPerUnit;
  final String weightUnit;

  ProductDetails({
    required this.id,
    required this.price,
    this.compareAtPrice,
    required this.trackInventory,
    required this.totalStock,
    this.weightPerUnit,
    required this.weightUnit,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      price: json['price'],
      compareAtPrice: json['compare_at_price'],
      trackInventory: json['track_inventory'],
      totalStock: json['total_stock'],
      weightPerUnit: (json['weight_per_unit'] != null)
          ? (json['weight_per_unit'] as num).toDouble()
          : null,
      weightUnit: json['weight_unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'compare_at_price': compareAtPrice,
      'track_inventory': trackInventory,
      'total_stock': totalStock,
      'weight_per_unit': weightPerUnit,
      'weight_unit': weightUnit,
    };
  }
}

class ProductVariant {
  final int id;
  final String? title;
  final String? option1;
  final String? option2;
  final String? option3;
  final VariantDetails? details;

  ProductVariant({
    required this.id,
    this.title,
    this.option1,
    this.option2,
    this.option3,
    this.details,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      title: json['title'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      details: json['details'] != null
          ? VariantDetails.fromJson(json['details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'details': details?.toJson(),
    };
  }
}

class VariantDetails {
  final int? price;
  final bool trackInventory;
  final int totalStock;
  final String? weightUnit;

  VariantDetails({
    this.price,
    required this.trackInventory,
    required this.totalStock,
    this.weightUnit,
  });

  factory VariantDetails.fromJson(Map<String, dynamic> json) {
    return VariantDetails(
      price: json['price'],
      trackInventory: json['track_inventory'] ?? false,
      totalStock: json['total_stock'] ?? 0,
      weightUnit: json['weight_unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'track_inventory': trackInventory,
      'total_stock': totalStock,
      'weight_unit': weightUnit,
    };
  }
}

class ProductMedia {
  final String? mediaId;
  final String? url;
  final String? thumbnailUrl;

  ProductMedia({this.mediaId, this.url, this.thumbnailUrl});

  factory ProductMedia.fromJson(Map<String, dynamic> json) {
    return ProductMedia(
      mediaId: json['media_id'],
      url: json['url'],
      thumbnailUrl: json['thumbnail_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'media_id': mediaId, 'url': url, 'thumbnail_url': thumbnailUrl};
  }
}

class ProductOption {
  final int? id;
  final String? name;
  final List<String> values;

  ProductOption({this.id, this.name, required this.values});

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return ProductOption(
      id: json['id'],
      name: json['name'],
      values: List<String>.from(json['values'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'values': values};
  }
}

  class PaginationModel {
  final int page;
  final int limit;
  final int total;
  final int pages;

  PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'page': page, 'limit': limit, 'total': total, 'pages': pages};
  }
}
