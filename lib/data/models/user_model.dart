class UserModel {
  final String id;
  final String? name;
  final String email;
  final String? avatar;
  final String? gender;

  UserModel({
    required this.id,
    this.name,
    required this.email,
    this.avatar,
    this.gender,
  });

  /// Supabase response → Model
  factory UserModel.fromSupabase(Map<String, dynamic> json) {
    return UserModel(
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      gender: json['gender'],
    );
  }
}
