import 'package:json_annotation/json_annotation.dart';
part 'tax_model.g.dart';

@JsonSerializable()
class Tax {
  int id;
  String name;
  double rate;
  bool standardRate;

  Tax(
      {required this.id,
      required this.name,
      required this.rate,
      required this.standardRate});

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);

  Map<String, dynamic> toJson() => _$TaxToJson(this);
}
