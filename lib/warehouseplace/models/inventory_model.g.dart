// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inventory _$InventoryFromJson(Map<String, dynamic> json) => Inventory(
      quantity: json['quantity'] as int,
      warehousePlacesId: json['warehouse_places_id'] as int,
      productsId: json['products_id'] as int,
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'warehouse_places_id': instance.warehousePlacesId,
      'products_id': instance.productsId,
    };
