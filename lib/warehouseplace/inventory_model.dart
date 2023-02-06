import 'package:json_annotation/json_annotation.dart';
part 'inventory_model.g.dart';

@JsonSerializable()
class Inventory {
  int quantity;
  @JsonKey(name: 'warehouse_places_id')
  int warehousePlacesId;
  @JsonKey(name: 'products_id')
  int productsId;
  Inventory(
      {required this.quantity,
      required this.warehousePlacesId,
      required this.productsId});

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}
