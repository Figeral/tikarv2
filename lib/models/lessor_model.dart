import 'package:equatable/equatable.dart';
import 'package:tikar/models/staff_model.dart';

class LessorModel extends Equatable {
  final int? id;
  final String fname, lname, gender;
  final int tel;
  final bool isActive;
  final bool inCameroon;

  final DateTime createdAt;
  final DateTime updatedAt;
  const LessorModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.tel,
    this.isActive = true,
    required this.inCameroon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessorModel.fromJson(Map<String, dynamic> json) {
    return LessorModel(
      id: json['id'] as int?,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      gender: json['gender'] as String,
      tel: json['tel'] as int,
      isActive: json['isActive'] as bool? ?? true,
      inCameroon: json['inCameroon'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
      'inCameroon': inCameroon,
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
      'inCameroon': inCameroon,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props =>
      [id, fname, lname, gender, tel, isActive, inCameroon];
  LessorModel copyWith(
          {String? fname,
          String? lname,
          String? gender,
          int? tel,
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? inCameroon,
          StaffModel? addedby}) =>
      LessorModel(
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        gender: gender ?? this.gender,
        tel: tel ?? this.tel,
        inCameroon: inCameroon ?? this.inCameroon,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
