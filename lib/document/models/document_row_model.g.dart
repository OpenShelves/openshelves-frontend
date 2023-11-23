// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentRowModel _$DocumentRowModelFromJson(Map<String, dynamic> json) =>
    DocumentRowModel(
      pos: json['pos'] as int,
      documentId: json['documentId'] as int,
      productName: json['productName'] as String,
    )
      ..id = json['id'] as int?
      ..product = json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>)
      ..netPrice = (json['netPrice'] as num?)?.toDouble()
      ..grossPrice = (json['grossPrice'] as num?)?.toDouble()
      ..quantity = (json['quantity'] as num?)?.toDouble()
      ..tax = json['tax'] == null
          ? null
          : Tax.fromJson(json['tax'] as Map<String, dynamic>);

Map<String, dynamic> _$DocumentRowModelToJson(DocumentRowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pos': instance.pos,
      'documentId': instance.documentId,
      'product': instance.product,
      'productName': instance.productName,
      'netPrice': instance.netPrice,
      'grossPrice': instance.grossPrice,
      'quantity': instance.quantity,
      'tax': instance.tax,
    };
