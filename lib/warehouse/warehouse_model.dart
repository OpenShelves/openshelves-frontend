import 'package:json_annotation/json_annotation.dart';
import 'package:openshelves/address_model.dart';
part 'warehouse_model.g.dart';

@JsonSerializable()
class Warehouse {
  int? id;
  String name;
  Address address;

  @override
  String toString() {
    return toJson().toString();
  }

  Warehouse({
    required this.name,
    this.id,
    required this.address,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseFromJson(json);
  Map<String, dynamic> toJson() => _$WarehouseToJson(this);
}
