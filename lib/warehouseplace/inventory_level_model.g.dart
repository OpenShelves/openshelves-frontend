// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryLevel _$InventoryLevelFromJson(Map<String, dynamic> json) =>
    InventoryLevel(
      quantity: json['quantity'] as int,
      warehousePlacesId: json['warehouse_places_id'] as int,
      productsId: json['products_id'] as int,
      productsName: json['products_name'] as String,
      warehousePlacesName: json['warehouse_places_name'] as String,
    );

Map<String, dynamic> _$InventoryLevelToJson(InventoryLevel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'warehouse_places_id': instance.warehousePlacesId,
      'products_id': instance.productsId,
      'products_name': instance.productsName,
      'warehouse_places_name': instance.warehousePlacesName,
    };
