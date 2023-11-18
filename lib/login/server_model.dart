import 'package:json_annotation/json_annotation.dart';
part 'server_model.g.dart';

@JsonSerializable()
  class Server {
  String uri;

  Server({required this.uri});

  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);

  Map<String, dynamic> toJson() => _$ServerToJson(this);
}
