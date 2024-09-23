import 'package:equatable/equatable.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/models/lessor_model.dart';

class AssetModel extends Equatable {
  final int? id;
  final LessorModel? lessor;
  final StaffModel? addedBy;
  final int? numberOfFloors;
  final int? numberOfHalls;
  final int? surfaceArea;
  final int? estimatedValue;
  final String? matricule;

  final String? address;
  final String? ville;
  final String? description;
  final String? assetType;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String?>? image;

  AssetModel(
      {this.id,
      this.lessor,
      this.addedBy,
      this.numberOfFloors,
      this.numberOfHalls,
      this.surfaceArea,
      this.estimatedValue,
      this.matricule,
      this.address,
      this.ville,
      this.description,
      this.assetType,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.image});

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      lessor: LessorModel.fromJson(json['lessor']),
      addedBy: StaffModel.fromJson(json['addedBy']),
      matricule: json['matricule'],
      surfaceArea: json['surfaceArea'],
      image: List<String>.from(json['image']),
      estimatedValue: json['estimatedValue'],
      numberOfFloors: json['numberOfFloors'],
      numberOfHalls: json['numberOfHalls'],
      address: json['address'],
      ville: json['ville'],
      description: json['description'],
      assetType: json['assetType'],
      isActive: json['active'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessor': lessor?.toJson(),
      'addedBy': addedBy!
          .toJson(), // since  this logic is already processed in the server
      'matricule': matricule,
      'surfaceArea': surfaceArea,
      'estimatedValue': estimatedValue,
      'numberOfFloors': numberOfFloors,
      'numberOfHalls': numberOfHalls,
      'address': address,
      'ville': ville,
      'description': description,
      'assetType': assetType,
      "image": image,
      'active': isActive,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'lessor': lessor?.toJson(),
      'matricule': matricule,
      'surfaceArea': surfaceArea,
      'estimatedValue': estimatedValue,
      'numberOfFloors': numberOfFloors,
      'numberOfHalls': numberOfHalls,
      'address': address,
      'ville': ville,
      'description': description,
      'assetType': assetType,
      "image": image,
      'active': isActive,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
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
      address,
      ville,
      description,
      assetType,
      isActive,
      createdAt,
      updatedAt,
      image,
    ];
  }

  @override
  List<Object?> get props => toList();

  AssetModel copyWith(
      {int? id,
      LessorModel? lessor,
      StaffModel? addedBy,
      int? numberOfFloors,
      int? numberOfHalls,
      int? surfaceArea,
      int? estimatedValue,
      String? matricule,
      String? address,
      String? ville,
      String? description,
      String? assetType,
      bool? isActive,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<String?>? image}) {
    return AssetModel(
      id: id ?? this.id,
      lessor: lessor ?? this.lessor,
      addedBy: addedBy ?? this.addedBy,
      numberOfFloors: numberOfFloors ?? this.numberOfFloors,
      numberOfHalls: numberOfHalls ?? this.numberOfHalls,
      surfaceArea: surfaceArea ?? this.surfaceArea,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      matricule: matricule ?? this.matricule,
      address: address ?? this.address,
      ville: ville ?? this.ville,
      image: image ?? this.image,
      description: description ?? this.description,
      assetType: assetType ?? this.assetType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BasementModel extends Equatable {
  final int? id;
  final StaffModel? addedBy;
  final AssetModel building;
  final String? description;
  final int surfaceArea;
  final int estimatedValue;
  final String? assetType;
  final int numberOfHalls;
  final String? matricule;
  final String? type;
  final bool active;
  final List<String?>? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  BasementModel(
      {this.id,
      this.addedBy,
      required this.building,
      this.description,
      required this.surfaceArea,
      required this.estimatedValue,
      required this.matricule,
      required this.createdAt,
      required this.updatedAt,
      this.assetType,
      required this.numberOfHalls,
      this.type,
      required this.active,
      this.image});

  factory BasementModel.fromJson(Map<String, dynamic> json) {
    return BasementModel(
      id: json['id'],
      addedBy: StaffModel.fromJson(json['addedStaff']),
      building: AssetModel.fromJson(json['building']),
      description: json['description'],
      surfaceArea: json['surfaceArea'],
      image: json['image'],
      estimatedValue: json['estimatedValue'],
      matricule: json['matricule'],
      assetType: json['assetType'],
      numberOfHalls: json['numberOfHalls'],
      type: json['type'],
      active: json['active'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addedStaff': addedBy?.toJson(),
      'building': building.toJson(),
      'description': description,
      'matricule': matricule,
      "image": image,
      'surfaceArea': surfaceArea,
      'estimatedValue': estimatedValue,
      'numberOfHalls': numberOfHalls,
      'type': type,
      'active': active,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
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
      matricule,
      surfaceArea,
      estimatedValue,
      assetType,
      numberOfHalls,
      type,
      active,
      image,
      createdAt,
      updatedAt
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
    String? matricule,
    int? numberOfHalls,
    List<String?>? image,
    DateTime? createdAt,
    DateTime? updatedAt,
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
      image: image ?? this.image,
      numberOfHalls: numberOfHalls ?? this.numberOfHalls,
      type: type ?? this.type,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      matricule: matricule ?? this.matricule,
    );
  }
}
