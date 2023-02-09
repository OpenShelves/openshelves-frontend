import 'package:json_annotation/json_annotation.dart';
part 'products_total_model.g.dart';

@JsonSerializable()
class ProductsTotal {
  int products;
  int quantity;

  ProductsTotal({
    required this.products,
    required this.quantity,
  });

  factory ProductsTotal.fromJson(Map<String, dynamic> json) =>
      _$ProductsTotalFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsTotalToJson(this);
}
