// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      name1: json['name1'] as String,
      id: json['id'] as int?,
      name2: json['name2'] as String?,
      name3: json['name3'] as String?,
      street: json['street'] as String?,
      housenumber: json['housenumber'] as String?,
      zip: json['zip'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'name1': instance.name1,
      'name2': instance.name2,
      'name3': instance.name3,
      'street': instance.street,
      'housenumber': instance.housenumber,
      'zip': instance.zip,
      'city': instance.city,
      'country': instance.country,
    };
