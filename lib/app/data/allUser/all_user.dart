import 'package:json_annotation/json_annotation.dart';
part 'all_user.g.dart';

@JsonSerializable()
class AllUsers {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "number")
  String? number;

  @JsonKey(name: "email")
  String? email;

  AllUsers({this.id, this.name, this.number, this.email});

  // flutter pub run build_runner build --delete-conflicting-outputs
  factory AllUsers.fromJson(Map<String, dynamic> json) => _$AllUsersFromJson(json);
  Map<String, dynamic> toJson() => _$AllUsersToJson(this);
}
