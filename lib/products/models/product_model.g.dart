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
      depth: (json['depth'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      active: Product._boolFromInt(json['active'] as int),
      price: Product.checkDouble(json['price']),
      sku: json['sku'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      quantity: json['quantity'] as String?,
    )..image = json['image'] as String?;

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  writeNotNull('asin', instance.asin);
  writeNotNull('ean', instance.ean);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('depth', instance.depth);
  writeNotNull('weight', instance.weight);
  val['active'] = Product._boolToInt(instance.active);
  writeNotNull('price', instance.price);
  writeNotNull('sku', instance.sku);
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('quantity', instance.quantity);
  writeNotNull('image', instance.image);
  return val;
}
