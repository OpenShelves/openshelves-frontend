// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentRowModel _$DocumentRowModelFromJson(Map<String, dynamic> json) =>
    DocumentRowModel(
      pos: json['pos'] as int,
      documentId: json['document_id'] as int,
      productName: json['product_name'] as String,
      id: json['id'] as int?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      netPrice: (json['net_price'] as num?)?.toDouble(),
      grossPrice: (json['gross_price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      tax: json['tax'] == null
          ? null
          : Tax.fromJson(json['tax'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentRowModelToJson(DocumentRowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pos': instance.pos,
      'document_id': instance.documentId,
      'product': instance.product,
      'product_name': instance.productName,
      'net_price': instance.netPrice,
      'gross_price': instance.grossPrice,
      'quantity': instance.quantity,
      'tax': instance.tax,
    };
