// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chats _$ChatsFromJson(Map<String, dynamic> json) => Chats(
  id: json['id'] as String?,
  created_on: json['created_on'] as String?,
  users: json['users'] as Map<String, dynamic>?,
  friend_name: json['friend_name'] as String?,
  user_name: json['user_name'] as String?,
  toId: json['toId'] as String?,
  fromId: json['fromId'] as String?,
  last_msg: json['last_msg'] as String?,
);

Map<String, dynamic> _$ChatsToJson(Chats instance) => <String, dynamic>{
  'id': instance.id,
  'users': instance.users,
  'friend_name': instance.friend_name,
  'user_name': instance.user_name,
  'toId': instance.toId,
  'fromId': instance.fromId,
  'created_on': instance.created_on,
  'last_msg': instance.last_msg,
};
