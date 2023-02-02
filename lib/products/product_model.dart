import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String name;
  String? asin;
  String? ean;
  num? width;
  num? height;
  num? depth;
  num? weight;
  @JsonKey(fromJson: _boolFromInt, toJson: _boolToInt)
  bool? active;
  num? price;
  String? sku;

  String toString() {
    return 'Product: {ean: ${ean}, count: ${name}}';
  }
  // int warehouses_id;

  Product({
    required this.name,
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
  });

  static bool _boolFromInt(int active) => active == 1;
  static int _boolToInt(bool? active) => active != null && active ? 1 : 0;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   // print(json);
  //   return Product(
  //     name: json['name'],
  //     id: json['id'],
  //     asin: json['asin'] ?? '',
  //     ean: json['ean'] ?? '',
  //     depth: json['depth'] ?? null,
  //     height: json['height'] ?? null,
  //     width: json['width'] ?? null,
  //     weight: json['weight'] ?? null,
  //     // active: (json['active'] != null && json['active'] == 1) ? true : false,
  //     price: json['price'] ?? null,
  //     sku: json['sku'] ?? null,
  //   );
  // }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
