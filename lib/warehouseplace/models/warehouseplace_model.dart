import 'package:json_annotation/json_annotation.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';

part 'warehouseplace_model.g.dart';

@JsonSerializable()
class WarehousePlace {
  int? id;
  String name;
  Warehouse warehouse;
  WarehousePlace? parent;
  String barcode;

  WarehousePlace(
      {this.id,
      required this.name,
      required this.warehouse,
      this.parent,
      this.barcode = ''});

  factory WarehousePlace.fromJson(Map<String, dynamic> json) =>
      _$WarehousePlaceFromJson(json);
  Map<String, dynamic> toJson() => _$WarehousePlaceToJson(this);
}
