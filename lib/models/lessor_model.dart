import 'package:equatable/equatable.dart';
import 'package:tikar/models/staff_model.dart';

class LessorModel extends Equatable {
  final int? id;
  final String fname, lname, gender;
  final int tel;
  final bool isActive;
  final bool inCameroon;
  final StaffModel addebBy;
  const LessorModel(
      {this.id,
      required this.fname,
      required this.lname,
      required this.gender,
      required this.tel,
      this.isActive = true,
      required this.inCameroon,
      required this.addebBy});

  factory LessorModel.fromJson(Map<String, dynamic> json) {
    return LessorModel(
      id: json['id'] as int?,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      gender: json['gender'] as String,
      addebBy: StaffModel.fromJson(json['addedby']),
      tel: json['tel'] as int,
      isActive: json['isActive'] as bool? ?? true,
      inCameroon: json['inCameroon'] as bool,
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
      'addedby': addebBy.toJson()
    };
  }

  @override
  List<Object?> get props =>
      [id, fname, lname, gender, tel, isActive, inCameroon, addebBy];
  LessorModel copyWith(
          {String? fname,
          String? lname,
          String? gender,
          int? tel,
          bool? isActive,
          bool? inCameroon,
          StaffModel? addedby}) =>
      LessorModel(
          fname: fname ?? this.fname,
          lname: lname ?? this.lname,
          gender: gender ?? this.gender,
          tel: tel ?? this.tel,
          inCameroon: inCameroon ?? this.inCameroon,
          addebBy: addedby ?? addebBy);
}
