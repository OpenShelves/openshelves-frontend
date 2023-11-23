import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String name;
  String? asin;
  String? ean;
  double? width;
  double? height;
  double? depth;
  double? weight;
  @JsonKey(fromJson: _boolFromInt, toJson: _boolToInt)
  bool? active;
  double? price;
  String? sku;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  String? quantity;

  @override
  String toString() {
    return 'Product: {ean: $ean, count: $name}';
  }
  // int warehouses_id;

  Product(
      {required this.name,
      this.id,
      this.asin,
      this.ean,
      this.depth,
      this.height,
      this.width,
      this.weight,
      this.active,
      this.price,
      this.sku,
      this.updatedAt,
      this.quantity});

  static bool _boolFromInt(int active) => active == 1;
  static int _boolToInt(bool? active) => active != null && active ? 1 : 0;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
