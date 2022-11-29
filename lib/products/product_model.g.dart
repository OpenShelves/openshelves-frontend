// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      id: json['id'] as int?,
      asin: json['asin'] as String?,
      ean: json['ean'] as String?,
      depth: json['depth'] as num?,
      height: json['height'] as num?,
      width: json['width'] as num?,
      weight: json['weight'] as num?,
      active: json['active'] as bool?,
      price: json['price'] as num?,
      sku: json['sku'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'asin': instance.asin,
      'ean': instance.ean,
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
      'weight': instance.weight,
      'active': instance.active,
      'price': instance.price,
      'sku': instance.sku,
    };
