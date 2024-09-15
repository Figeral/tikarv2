import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  final int id;
  final String fname, lname;
  final int tel;
  final bool active;
  final String? picture;
  final List<String> role;
  final List<Map<String, String>> authorities;
  final String? post;
  final String email;
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool accountNonExpired;
  final bool enabled;
  final bool accountNonLocked;
  final bool credentialsNonExpired;
  const StaffModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.tel,
    required this.active,
    this.picture,
    required this.role,
    required this.authorities,
    this.post,
    required this.email,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
    required this.accountNonExpired,
    required this.enabled,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      tel: json['tel'],
      active: json['active'],
      picture: json['picture'],
      role: List<String>.from(json['role']),
      authorities: List<Map<String, String>>.from(
        json['authorities'].map((x) => Map<String, String>.from(x)),
      ),
      post: json['post'],
      email: json['email'],
      username: json['username'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      accountNonExpired: json['accountNonExpired'],
      enabled: json['enabled'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'tel': tel,
      'active': active,
      'picture': picture,
      'role': role,
      'authorities': authorities,
      'post': post,
      'email': email,
      'username': username,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'accountNonExpired': accountNonExpired,
      'enabled': enabled,
      'accountNonLocked': accountNonLocked,
      'credentialsNonExpired': credentialsNonExpired,
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'fname': fname,
      'lname': lname,
      'tel': tel,
      'active': active,
      'picture': picture,
      'role': role,
      'authorities': authorities,
      'post': post,
      'email': email,
      'username': username,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'accountNonExpired': accountNonExpired,
      'enabled': enabled,
      'accountNonLocked': accountNonLocked,
      'credentialsNonExpired': credentialsNonExpired,
    };
  }

  List<dynamic> toList() {
    return [
      id,
      fname,
      lname,
      tel,
      active,
      picture,
      role,
      authorities,
      post,
      email,
      username,
      createdAt,
      updatedAt,
      accountNonExpired,
      enabled,
      accountNonLocked,
      credentialsNonExpired,
    ];
  }

  @override
  List<Object?> get props => toList();
  StaffModel copyWith({
    int? id,
    String? fname,
    String? lname,
    int? tel,
    bool? active,
    String? picture,
    List<String>? role,
    List<Map<String, String>>? authorities,
    String? post,
    String? email,
    String? username,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? accountNonExpired,
    bool? enabled,
    bool? accountNonLocked,
    bool? credentialsNonExpired,
  }) {
    return StaffModel(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      tel: tel ?? this.tel,
      active: active ?? this.active,
      picture: picture ?? this.picture,
      role: role ?? List.from(this.role),
      authorities: authorities ?? List.from(this.authorities),
      post: post ?? this.post,
      email: email ?? this.email,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      accountNonExpired: accountNonExpired ?? this.accountNonExpired,
      enabled: enabled ?? this.enabled,
      accountNonLocked: accountNonLocked ?? this.accountNonLocked,
      credentialsNonExpired:
          credentialsNonExpired ?? this.credentialsNonExpired,
    );
  }
}

enum StaffRole {
  owner,
  admin,
  manager,
  extern;

  String toJson() => name;
  static StaffRole fromJson(String json) => values.byName(json);
}
