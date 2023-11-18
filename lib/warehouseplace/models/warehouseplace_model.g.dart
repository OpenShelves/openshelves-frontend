// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouseplace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehousePlace _$WarehousePlaceFromJson(Map<String, dynamic> json) =>
    WarehousePlace(
      id: json['id'] as int?,
      name: json['name'] as String,
      warehouse: Warehouse.fromJson(json['warehouse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WarehousePlaceToJson(WarehousePlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'warehouse': instance.warehouse,
    };
