class MerchantModel {
  final String id;
  final String? name;
  final String email;
  final String? avatar;
  final String? gender;

  MerchantModel({
    required this.id,
    this.name,
    required this.email,
    this.avatar,
    this.gender,
  });

  /// Supabase response → Model
  factory MerchantModel.fromSupabase(Map<String, dynamic> json) {
    return MerchantModel(
      id: json['id'],
      name: json['user_metadata']?['name'] ??'',
      email: json['email'],
      avatar: json['user_metadata']?['avatar'],
      gender: json['user_metadata']?['gender'],
    );
  }

  /// Sembast save
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatar': avatar,
        'gender': gender,
      };

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      gender: json['gender'],
    );
  }
}
