class CustomerResponseModel {
  final bool error;
  final int errorCode;
  final String message;
  final List<CustomerModel> data;
  final PaginationModel? pagination;
  final int status;

  CustomerResponseModel({
    required this.error,
    required this.errorCode,
    required this.message,
    required this.data,
    this.pagination,
    required this.status,
  });

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerResponseModel(
      error: json['error'] ?? false,
      errorCode: json['error_code'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((i) => CustomerModel.fromJson(i))
          .toList(),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'error_code': errorCode,
      'message': message,
      'data': data.map((i) => i.toJson()).toList(),
      'pagination': pagination?.toJson(),
      'status': status,
    };
  }
}

class CustomerModel {
  final int customerId;
  final String? supabaseId;
  final String name;
  final String? avatar;
  final String? email;
  final String? phone;
  final String? gender;
  final String status;
  final bool anonymous;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomerModel({
    required this.customerId,
    this.supabaseId,
    required this.name,
    this.avatar,
    this.email,
    this.phone,
    this.gender,
    required this.status,
    required this.anonymous,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json['customer_id'] ?? 0,
      supabaseId: json['supabase_id'],
      name: json['name'] ?? '',
      avatar: json['avatar'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      status: json['status'] ?? '',
      anonymous: json['anonymous'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'supabase_id': supabaseId,
      'name': name,
      'avatar': avatar,
      'email': email,
      'phone': phone,
      'gender': gender,
      'status': status,
      'anonymous': anonymous,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
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
