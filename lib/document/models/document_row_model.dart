import 'package:json_annotation/json_annotation.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/settings/tax/models/tax_model.dart';
part 'document_row_model.g.dart';

@JsonSerializable()
class DocumentRowModel {
  int? id;
  int pos;
  int documentId;
  Product? product;
  String productName;
  double? netPrice;
  double? grossPrice;
  double? quantity;
  Tax? tax;

  DocumentRowModel({
    required this.pos,
    required this.documentId,
    required this.productName,
  });

  factory DocumentRowModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentRowModelToJson(this);

  toString() {
    return 'DocumentRowModel: {id: $id, pos: $pos, documentId: $documentId, productId: $product, productName: $productName, netPrice: $netPrice, grossPrice: $grossPrice, quantity: $quantity}';
  }
}
