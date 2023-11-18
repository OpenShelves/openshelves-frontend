import 'package:json_annotation/json_annotation.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';

part 'warehouseplace_model.g.dart';

@JsonSerializable()
class WarehousePlace {
  final int? id;
  late final String name;
  late final Warehouse warehouse;

  WarehousePlace({this.id, required this.name, required this.warehouse});

  factory WarehousePlace.fromJson(Map<String, dynamic> json) =>
      _$WarehousePlaceFromJson(json);
  Map<String, dynamic> toJson() => _$WarehousePlaceToJson(this);
}
