import 'package:json_annotation/json_annotation.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/settings/tax/models/tax_model.dart';
part 'document_row_model.g.dart';

@JsonSerializable()
class DocumentRowModel {
  int? id;
  int pos;
  @JsonKey(name: 'document_id')
  int documentId;
  Product? product;
  @JsonKey(name: 'product_name')
  String productName;
  @JsonKey(name: 'net_price')
  double? netPrice;
  @JsonKey(name: 'gross_price')
  double? grossPrice;
  double? quantity;
  Tax? tax;

  DocumentRowModel({
    required this.pos,
    required this.documentId,
    required this.productName,
    this.id,
    this.product,
    this.netPrice,
    this.grossPrice,
    this.quantity,
    this.tax,
  });

  factory DocumentRowModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentRowModelToJson(this);

  toString() {
    return 'DocumentRowModel: {id: $id, pos: $pos, documentId: $documentId, productId: $product, productName: $productName, netPrice: $netPrice, grossPrice: $grossPrice, quantity: $quantity}';
  }
}
