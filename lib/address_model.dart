import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class Address {
  int? id;
  String name1;
  String? name2;
  String? name3;
  String? street;
  String? housenumber;
  String? zip;
  String? city;
  String? country;

  String toString() {
    return 'Address: {id: ${id}, name1: ${name1}}';
  }

  Address({
    required this.name1,
    this.id,
    this.name2,
    this.name3,
    this.street,
    this.housenumber,
    this.zip,
    this.city,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
