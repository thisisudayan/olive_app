class StoreModel {
  final int id;
  final String name;
  final RoleModel role;
  final String status;
  final DateTime lastUpdate;
  final InvitationModel? invitation;

  StoreModel({
    required this.id,
    required this.name,
    required this.role,
    required this.status,
    required this.lastUpdate,
    this.invitation,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['store_id'],
      name: json['store_name'],
      role: RoleModel.fromJson(json['role']),
      status: json['store_status'],
      lastUpdate: DateTime.parse(json['updated_at']),
      invitation: json['invitation'] != null
          ? InvitationModel.fromJson(json['invitation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': id,
      'store_name': name,
      'role': role.toJson(),
      'store_status': status,
      'updated_at': lastUpdate.toIso8601String(),
      'invitation': invitation?.toJson(),
    };
  }
}

class RoleModel {
  final int id;
  final String name;

  RoleModel({required this.id, required this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class InvitationModel {
  final int id;
  final String status;

  InvitationModel({required this.id, required this.status});

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['invitation_id'],
      status: json['invitation_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'invitation_id': id, 'invitation_status': status};
  }
}
