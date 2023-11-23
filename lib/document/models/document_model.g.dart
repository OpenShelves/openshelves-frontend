// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      documentType: json['document_type'] as int,
      documentStatus: json['document_status'] as int,
      documentNumber: json['document_number'] as String,
      documentDate: DateTime.parse(json['document_date'] as String),
    )
      ..id = json['id'] as int?
      ..billingAddress = json['billingAddress'] == null
          ? null
          : Address.fromJson(json['billingAddress'] as Map<String, dynamic>)
      ..deliveryAddress = json['deliveryAddress'] == null
          ? null
          : Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>);

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'document_type': instance.documentType,
      'document_status': instance.documentStatus,
      'document_number': instance.documentNumber,
      'document_date': instance.documentDate.toIso8601String(),
      'billingAddress': instance.billingAddress,
      'deliveryAddress': instance.deliveryAddress,
    };
