import 'package:json_annotation/json_annotation.dart';
part 'inventory_level_model.g.dart';

@JsonSerializable()
class InventoryLevel {
  int quantity;
  @JsonKey(name: 'warehouse_places_id')
  int warehousePlacesId;
  @JsonKey(name: 'products_id')
  int productsId;
  @JsonKey(name: 'products_name')
  String productsName;
  @JsonKey(name: 'warehouse_places_name')
  String warehousePlacesName;
  InventoryLevel(
      {required this.quantity,
      required this.warehousePlacesId,
      required this.productsId,
      required this.productsName,
      required this.warehousePlacesName});

  factory InventoryLevel.fromJson(Map<String, dynamic> json) =>
      _$InventoryLevelFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryLevelToJson(this);
}
