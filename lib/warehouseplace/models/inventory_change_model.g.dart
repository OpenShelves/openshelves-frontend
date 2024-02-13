// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_change_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryChange _$InventoryChangeFromJson(Map<String, dynamic> json) =>
    InventoryChange(
      quantity: json['quantity'] as int,
      warehousePlace: WarehousePlace.fromJson(
          json['warehouse_place'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InventoryChangeToJson(InventoryChange instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'warehouse_place': instance.warehousePlace,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'product': instance.product,
    };
