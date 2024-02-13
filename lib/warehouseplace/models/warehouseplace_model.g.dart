// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouseplace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehousePlace _$WarehousePlaceFromJson(Map<String, dynamic> json) =>
    WarehousePlace(
      id: json['id'] as int?,
      name: json['name'] as String,
      warehouse: json['warehouse'] == null
          ? null
          : Warehouse.fromJson(json['warehouse'] as Map<String, dynamic>),
      parent: json['parent_warehouse_place'] == null
          ? null
          : WarehousePlace.fromJson(
              json['parent_warehouse_place'] as Map<String, dynamic>),
      barcode: json['barcode'] as String? ?? '',
    );

Map<String, dynamic> _$WarehousePlaceToJson(WarehousePlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'warehouse': instance.warehouse,
      'parent_warehouse_place': instance.parent,
      'barcode': instance.barcode,
    };
