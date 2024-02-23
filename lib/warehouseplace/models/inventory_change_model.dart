import 'package:json_annotation/json_annotation.dart';
import 'package:openshelves/products/models/product_model.dart';

import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
part 'inventory_change_model.g.dart';

@JsonSerializable()
class InventoryChange {
  int quantity;

  @JsonKey(name: 'warehouse_place')
  WarehousePlace warehousePlace;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  Product product;

  InventoryChange(
      {required this.quantity,
      required this.warehousePlace,
      required this.createdAt,
      required this.updatedAt,
      required this.product});

  factory InventoryChange.fromJson(Map<String, dynamic> json) =>
      _$InventoryChangeFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryChangeToJson(this);

  @override
  String toString() {
    return 'InventoryChange{quantity: $quantity, warehousePlace: $warehousePlace, product: $product}';
  }
}
