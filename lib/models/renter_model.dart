import 'package:equatable/equatable.dart';

class RenterModel extends Equatable {
  final int id;
  final String fname, lname, gender;
  final String? picture;
  final int tel;
  final bool isActive;
//  final StaffModel addedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RenterModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.tel,
    required this.isActive,
    required this.picture,
    // required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RenterModel.fromJson(Map<String, dynamic> json) {
    return RenterModel(
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      id: json['id'] as int,
      gender: json['gender'] as String? ?? '',
      fname: json['fname'] as String? ?? '',
      lname: json['lname'] as String? ?? '',
      tel: json['tel'] as int? ?? 0,
      picture: json['picture'] as String?,
      isActive: json['active'] as bool? ?? false,

      //   addedBy: StaffModel.fromJson(json['addedby'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'gender': gender,
      'tel': tel,
      'isActive': isActive,
      "picture": picture,
      // "addedby": addedBy.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return toJson().remove("id");
  }

  @override
  List<Object?> get props => [
        id,
        fname,
        lname,
        gender,
        tel,
        isActive, picture,
        //  addedBy,
      ];
  RenterModel copyWith({
    String? fname,
    String? lname,
    String? gender,
    int? tel,
    bool? isActive,
    String? picture,
    DateTime? createdAt,
    DateTime? updatedAt,
    // StaffModel? staff,
  }) =>
      RenterModel(
        id: id,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        gender: gender ?? this.gender,
        tel: this.tel,
        isActive: isActive ?? this.isActive,
        picture: picture,
        //     addedBy: staff ?? addedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
