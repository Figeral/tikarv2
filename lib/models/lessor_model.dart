import 'package:equatable/equatable.dart';
import 'package:tikar/models/staff_model.dart';

class LessorModel extends Equatable {
  final int? id;
  final String fname, lname, gender;
  final int tel;
  final bool isActive;
  final StaffModel? addedBy;
  final bool inCameroon;

  final DateTime createdAt;
  final DateTime updatedAt;
  String? image;
  LessorModel(
      {this.id,
      required this.fname,
      required this.lname,
      required this.gender,
      required this.tel,
      this.isActive = true,
      this.addedBy,
      required this.inCameroon,
      required this.createdAt,
      required this.updatedAt,
      this.image});

  factory LessorModel.fromJson(Map<String, dynamic> json) {
    return LessorModel(
        id: json['id'] as int?,
        fname: json['fname'] as String,
        lname: json['lname'] as String,
        gender: json['gender'] as String,
        tel: json['tel'] as int,
        isActive: json['active'] as bool? ?? true,
        image: json['picture'],
        inCameroon: json['inCameroon'] as bool,
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
        addedBy: StaffModel.fromJson(json['addedStaff']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'gender': gender,
      'tel': tel,
      'active': isActive,
      "picture": image,
      'inCameroon': inCameroon,
      "addedStaff": addedBy?.toJson(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'fname': fname,
      'lname': lname,
      'gender': gender,
      'tel': tel,
      'active': isActive,
      "picture": image,
      'inCameroon': inCameroon,
      "addedStaff": addedBy?.toJson(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object?> get props =>
      [id, fname, lname, gender, tel, isActive, inCameroon, addedBy, image];
  LessorModel copyWith(
          {String? fname,
          String? lname,
          String? gender,
          int? tel,
          bool? isActive,
          String? image,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? inCameroon,
          StaffModel? addedby}) =>
      LessorModel(
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        gender: gender ?? this.gender,
        tel: tel ?? this.tel,
        image: image ?? this.image,
        inCameroon: inCameroon ?? this.inCameroon,
        addedBy: addedby ?? addedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
