import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  final int? id;
  final String fname, lname;
  final int tel;
  final bool active;
  final String? picture;
  final List<String> role;
  final List<Map<String, dynamic>>? authorities;
  final String? post;
  final String email;
  final String password;
  final String username;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? accountNonExpired;
  final bool? enabled;
  final bool? accountNonLocked;
  final bool? credentialsNonExpired;

  const StaffModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.tel,
    required this.active,
    this.picture,
    required this.password,
    required this.role,
    this.authorities,
    required this.post,
    required this.email,
    required this.username,
    this.createdAt,
    this.updatedAt,
    this.accountNonExpired,
    this.enabled,
    this.accountNonLocked,
    this.credentialsNonExpired,
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
      authorities: List<Map<String, dynamic>>.from(
        json['authorities'].map((x) => {'authority': x['authority']}),
      ),
      post: json['post'],
      email: json['email'],
      username: json['username'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
      accountNonExpired: json['accountNonExpired'],
      enabled: json['enabled'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
      password: json["password"],
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
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'accountNonExpired': accountNonExpired,
      'enabled': enabled,
      'accountNonLocked': accountNonLocked,
      'credentialsNonExpired': credentialsNonExpired,
      "password": password,
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
      "password": password,
      // 'authorities': authorities,
      'post': post,
      'email': email,
      'username': username,
      // 'createdAt': createdAt?.toIso8601String(),
      // 'updatedAt': updatedAt?.toIso8601String(),
      // 'accountNonExpired': accountNonExpired,
      // 'enabled': enabled,
      // 'accountNonLocked': accountNonLocked,
      // 'credentialsNonExpired': credentialsNonExpired,
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
      password,
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
    String? pw,
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
      password: pw ?? this.password,
      picture: picture ?? this.picture,
      role: role ?? List.from(this.role),
      authorities: authorities ?? List.from(this.authorities!),
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
