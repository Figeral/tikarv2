import 'package:equatable/equatable.dart';
import 'package:tikar/models/staff_model.dart';

class RenterModel extends Equatable {
  final int? id;
  final String fname, lname, gender;
  final String? picture;
  final int tel;
  final bool isActive;
  final StaffModel? addedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RenterModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.tel,
    required this.isActive,
    this.picture,
    this.addedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RenterModel.fromJson(Map<String, dynamic> json) {
    return RenterModel(
        createdAt: json['createdAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'])
            : DateTime.now(),
        id: json['id'] as int,
        gender: json['gender'] as String? ?? '',
        fname: json['fname'] as String? ?? '',
        lname: json['lname'] as String? ?? '',
        tel: json['tel'] as int? ?? 0,
        picture: json['picture'] as String?,
        isActive: json['active'] as bool? ?? false,
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
      "picture": picture,
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
      "picture": picture,
      "addedStaff": addedBy?.toJson(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object?> get props => [
        id,
        fname,
        lname,
        gender,
        tel,
        isActive,
        picture,
        addedBy,
        createdAt,
        updatedAt
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
    StaffModel? staff,
  }) =>
      RenterModel(
        id: id,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        gender: gender ?? this.gender,
        tel: this.tel,
        isActive: isActive ?? this.isActive,
        picture: picture,
        addedBy: staff ?? addedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RenterModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
