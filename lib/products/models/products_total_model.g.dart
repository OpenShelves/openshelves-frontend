// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_total_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsTotal _$ProductsTotalFromJson(Map<String, dynamic> json) =>
    ProductsTotal(
      products: json['products'] as int,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$ProductsTotalToJson(ProductsTotal instance) =>
    <String, dynamic>{
      'products': instance.products,
      'quantity': instance.quantity,
    };
