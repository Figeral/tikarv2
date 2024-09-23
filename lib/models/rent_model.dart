import 'package:equatable/equatable.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:tikar/models/renter_model.dart';

class RentModel extends Equatable {
  final int? id;
  final DateTime? startAt;
  final DateTime? endAt;
  final AssetModel? asset;
  final BasementModel? basement;

  final DateTime createdAt;
  final DateTime updatedAt;
  final RenterModel renter;
  final bool active;
  final int cost;

  const RentModel({
    this.id,
    this.startAt,
    this.endAt,
    this.asset,
    this.basement,
    required this.createdAt,
    required this.updatedAt,
    required this.renter,
    required this.active,
    required this.cost,
  });

  factory RentModel.fromJson(Map<String, dynamic> json) {
    return RentModel(
      id: json['id'],
      startAt: json['startAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['startAt'])
          : null,
      endAt: json['endAt'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(json['endAt'])
          : null,
      asset: json['asset'] != null ? AssetModel.fromJson(json['asset']) : null,
      basement:
          json['basement'] != null ? BasementModel.fromJson(json['basement']) : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
      renter: RenterModel.fromJson(json['renter']),
      active: json['active'],
      cost: json['cost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startAt': startAt?..millisecondsSinceEpoch,
      'endAt': endAt?..millisecondsSinceEpoch,
      'asset': asset?.toJson(),
      "basement": basement?.toJson(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'renter': renter.toJson(),
      'active': active,
      'cost': cost,
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
      startAt,
      endAt,
      asset,
      basement,
      createdAt,
      updatedAt,
      renter,
      active,
      cost
    ];
  }

  @override
  List<Object?> get props => toList();

  RentModel copyWith({
    int? id,
    DateTime? startAt,
    DateTime? endAt,
    AssetModel? asset,
    BasementModel? basement,
    DateTime? createdAt,
    DateTime? updatedAt,
    RenterModel? renter,
    bool? active,
    int? cost,
  }) {
    return RentModel(
      id: id ?? this.id,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      asset: asset ?? this.asset,
      basement: basement ?? this.basement,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      renter: renter ?? this.renter,
      active: active ?? this.active,
      cost: cost ?? this.cost,
    );
  }
}
