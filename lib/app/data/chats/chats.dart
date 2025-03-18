import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chats.g.dart';

@JsonSerializable()
class Chats {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "users")
  Map<String, dynamic>? users;

  @JsonKey(name: "friend_name")
  String? friend_name;

  @JsonKey(name: "user_name")
  String? user_name;

  @JsonKey(name: "toId")
  String? toId;

  @JsonKey(name: "fromId")
  String? fromId;

  @JsonKey(name: "created_on")
  String? created_on;

  @JsonKey(name: "last_msg")
  String? last_msg;

  Chats({
    this.id,
    this.created_on,
    this.users,
    this.friend_name,
    this.user_name,
    this.toId,
    this.fromId,
    this.last_msg,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => _$ChatsFromJson(json);
  Map<String, dynamic> toJson() => _$ChatsToJson(this);
}
