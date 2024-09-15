import 'package:equatable/equatable.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/models/lessor_model.dart';

class AssetModel extends Equatable {
  final int id;
  final LessorModel? lessor;
  final StaffModel addedBy;
  final int? numberOfFloors;
  final int? numberOfHalls;
  final int surfaceArea;
  final int estimatedValue;
  final int? matricule;
  final String? name;
  final String? address;
  final String? ville;
  final String? description;
  final String assetType;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? type;

  const AssetModel({
    required this.id,
    this.lessor,
    required this.addedBy,
    this.numberOfFloors,
    this.numberOfHalls,
    required this.surfaceArea,
    required this.estimatedValue,
    this.matricule,
    this.name,
    this.address,
    this.ville,
    this.description,
    required this.assetType,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.type,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      lessor:
          json['lessor'] != null ? LessorModel.fromJson(json['lessor']) : null,
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessor': lessor?.toJson(),
      'addedBy': addedBy.toJson(),
      'matricule': matricule,
      'surfaceArea': surfaceArea,
      'estimatedValue': estimatedValue,
      'numberOfFloors': numberOfFloors,
      'numberOfHalls': numberOfHalls,
      'name': name,
      'address': address,
      'ville': ville,
      'description': description,
      'assetType': assetType,
      'type': type,
      'active': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  List<Object?> toList() {
    return [
      id,
      lessor,
      addedBy,
      numberOfFloors,
      numberOfHalls,
      surfaceArea,
      estimatedValue,
      matricule,
      name,
      address,
      ville,
      description,
      assetType,
      isActive,
      createdAt,
      updatedAt,
      type,
    ];
  }

  @override
  List<Object?> get props => toList();

  AssetModel copyWith({
    int? id,
    LessorModel? lessor,
    StaffModel? addedBy,
    int? numberOfFloors,
    int? numberOfHalls,
    int? surfaceArea,
    int? estimatedValue,
    int? matricule,
    String? name,
    String? address,
    String? ville,
    String? description,
    String? assetType,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? type,
  }) {
    return AssetModel(
      id: id ?? this.id,
      lessor: lessor ?? this.lessor,
      addedBy: addedBy ?? this.addedBy,
      numberOfFloors: numberOfFloors ?? this.numberOfFloors,
      numberOfHalls: numberOfHalls ?? this.numberOfHalls,
      surfaceArea: surfaceArea ?? this.surfaceArea,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      matricule: matricule ?? this.matricule,
      name: name ?? this.name,
      address: address ?? this.address,
      ville: ville ?? this.ville,
      description: description ?? this.description,
      assetType: assetType ?? this.assetType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
    );
  }
}

class BasementModel extends Equatable {
  final int id;
  final StaffModel addedBy;
  final AssetModel building;
  final String? description;
  final int surfaceArea;
  final int estimatedValue;
  final String? assetType;
  final int numberOfHalls;
  final String? type;
  final bool active;

  const BasementModel({
    required this.id,
    required this.addedBy,
    required this.building,
    this.description,
    required this.surfaceArea,
    required this.estimatedValue,
    this.assetType,
    required this.numberOfHalls,
    this.type,
    required this.active,
  });

  factory BasementModel.fromJson(Map<String, dynamic> json) {
    return BasementModel(
      id: json['id'],
      addedBy: StaffModel.fromJson(json['addedBy']),
      building: AssetModel.fromJson(json['building']),
      description: json['description'],
      surfaceArea: json['surfaceArea'],
      estimatedValue: json['estimatedValue'],
      assetType: json['assetType'],
      numberOfHalls: json['numberOfHalls'],
      type: json['type'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addedBy': addedBy.toJson(),
      'building': building.toJson(),
      'description': description,
      'surfaceArea': surfaceArea,
      'estimatedValue': estimatedValue,
      'assetType': assetType,
      'numberOfHalls': numberOfHalls,
      'type': type,
      'active': active,
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  List<Object?> toList() {
    return [
      id,
      addedBy,
      building,
      description,
      surfaceArea,
      estimatedValue,
      assetType,
      numberOfHalls,
      type,
      active,
    ];
  }

  @override
  List<Object?> get props => toList();

  BasementModel copyWith({
    int? id,
    StaffModel? addedBy,
    AssetModel? building,
    String? description,
    int? surfaceArea,
    int? estimatedValue,
    String? assetType,
    int? numberOfHalls,
    String? type,
    bool? active,
  }) {
    return BasementModel(
      id: id ?? this.id,
      addedBy: addedBy ?? this.addedBy,
      building: building ?? this.building,
      description: description ?? this.description,
      surfaceArea: surfaceArea ?? this.surfaceArea,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      assetType: assetType ?? this.assetType,
      numberOfHalls: numberOfHalls ?? this.numberOfHalls,
      type: type ?? this.type,
      active: active ?? this.active,
    );
  }
}
