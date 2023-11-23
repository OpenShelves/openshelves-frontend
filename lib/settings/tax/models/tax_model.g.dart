// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tax _$TaxFromJson(Map<String, dynamic> json) => Tax(
      name: json['tax_name'] as String,
      id: json['id'] as int?,
      rate: (json['rate'] as num).toDouble(),
      defaultTax: Tax._boolFromInt(json['defaultTax'] as int),
    );

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'id': instance.id,
      'tax_name': instance.name,
      'rate': instance.rate,
      'defaultTax': Tax._boolToInt(instance.defaultTax),
    };
