import 'package:json_annotation/json_annotation.dart';
part 'tax_model.g.dart';

@JsonSerializable()
class Tax {
  int? id;
  @JsonKey(name: 'tax_name')
  String name;
  double rate;
  @JsonKey(fromJson: _boolFromInt, toJson: _boolToInt)
  bool defaultTax;

  Tax(
      {required this.name,
      this.id,
      required this.rate,
      required this.defaultTax});

  static bool _boolFromInt(int active) => active == 1;
  static int _boolToInt(bool? active) => active != null && active ? 1 : 0;

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);

  Map<String, dynamic> toJson() => _$TaxToJson(this);
}
