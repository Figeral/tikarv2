import 'package:equatable/equatable.dart';
import 'package:tikar/models/staff_model.dart';

class RenterModel extends Equatable {
  final int id;
  final String fname, lname, gender;
  final int tel;
  final bool isActive;
  final StaffModel addedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RenterModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.tel,
    required this.isActive,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RenterModel.fromJson(Map<String, dynamic> json) {
    return RenterModel(
        id: json['id'] as int,
        fname: json['fname'] as String,
        lname: json['lname'] as String,
        gender: json['gender'] as String,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        tel: json['tel'] as int,
        isActive: json['isActive'] as bool,
        addedBy: StaffModel.fromJson(json['addedby']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'gender': gender,
      'tel': tel,
      'isActive': isActive,
      "addedby": addedBy.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'fname': fname,
      'lname': lname,
      'gender': gender,
      'tel': tel,
      'isActive': isActive,
      "addedby": addedBy.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, fname, lname, gender, tel, isActive, addedBy];
  RenterModel copyWith(
          {String? fname,
          String? lname,
          String? gender,
          int? tel,
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt,
          StaffModel? staff}) =>
      RenterModel(
        id: id,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        gender: gender ?? this.gender,
        tel: this.tel,
        isActive: isActive ?? this.isActive,
        addedBy: staff ?? addedBy,
      createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
