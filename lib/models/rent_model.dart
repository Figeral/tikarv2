import 'package:tikar/models/staff_model.dart';
import 'package:tikar/models/lessor_model.dart';

class AssetModel {
  int id;
  LessorModel? lessor;
  StaffModel addedBy;
  // List<BasementModel>? basements;
  int? numberOfFloors, numberOfHalls;
  int surfaceArea, estimatedValue;
  int? matricule;
  String? name, address, ville, description;
  String assetType;

  bool isActive;

  String? type;
  AssetModel({
    required this.id,
    required this.lessor,
    required this.addedBy,
    // required this.basements,
    required this.matricule,
    required this.surfaceArea,
    required this.estimatedValue,
    required this.numberOfFloors,
    this.numberOfHalls,
    required this.name,
    required this.address,
    required this.ville,
    required this.description,
    required this.assetType,
    required this.type,
    required this.isActive,
  });
  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      lessor:
          json["lessor"] != null ? LessorModel.fromJson(json['lessor']) : null,
      addedBy: StaffModel.fromJson(json['addedBy']),
      matricule: json['matricule'],
      surfaceArea: json['surfaceArea'],
      estimatedValue: json['estimatedValue'],
      numberOfFloors: json['numberOfFloors'],
      numberOfHalls: json['numberOfHalls'],
      name: json['name'],
      address: json['address'],
      ville: json['ville'],
      description: json['description'],
      assetType: json['assetType'],
      type: json['type'],
      isActive: json['active'],
    );
  }
}

class BasementModel {
  int id;

  StaffModel addedBy;
  AssetModel building;
  String? description;
  int surfaceArea;
  int estimatedValue;
  String? assetType;
  int numberOfHalls;
  String? type;
  bool active;
  BasementModel(
      {required this.id,
      required this.addedBy,
      required this.building,
      required this.description,
      required this.surfaceArea,
      required this.estimatedValue,
      required this.assetType,
      required this.numberOfHalls,
      required this.type,
      required this.active});
  factory BasementModel.fromJson(Map<String, dynamic> json) {
    return BasementModel(
        id: json['id'],
        addedBy: StaffModel.fromJson(json["addedBy"]),
        building: AssetModel.fromJson(json['building']),
        description: json['description'],
        surfaceArea: json["surfaceArea"],
        estimatedValue: json["estimatedValue"],
        assetType: json['assetType'],
        numberOfHalls: json['numberOfHalls'],
        type: json['type'],
        active: json['active']);
  }
}
