import 'package:json_annotation/json_annotation.dart';
import 'package:openshelves/address_model.dart';
part 'document_model.g.dart';

@JsonSerializable()
class Document {
  int? id;
  @JsonKey(name: 'document_type')
  int documentType;
  @JsonKey(name: 'document_status')
  int documentStatus;
  @JsonKey(name: 'document_number')
  String documentNumber;
  @JsonKey(name: 'document_date')
  DateTime documentDate;
  Address? billingAddress;
  Address? deliveryAddress;

  Document({
    required this.documentType,
    required this.documentStatus,
    required this.documentNumber,
    required this.documentDate,
    this.id,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
