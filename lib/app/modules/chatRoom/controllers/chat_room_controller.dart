import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRoomController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference chats;

  GetStorage box = GetStorage();
  Future<SharedPreferences> sPref = SharedPreferences.getInstance();

  dynamic chatId;
  var friendId;
  var friendName;
  var userId;
  var userName;

  TextEditingController messageController = TextEditingController();

  @override
  void onInit() async {
    chats = firestore.collection("chats");
    await getFriendId(); // Wait for friendId and userId to be initialized
    await getChatId(); // Wait for chatId to be initialized
    super.onInit();
  }

  // Fetch friendId and userId from SharedPreferences and GetStorage
  Future<void> getFriendId() async {
    final SharedPreferences sp = await sPref;
    friendId = sp.getString("id");
    friendName = sp.getString("name");

    Map<String, dynamic>? user = box.read('loginData');
    if (user != null) {
      userId = user['id'];
      userName = user['name'];
    } else {
      throw Exception("User data not found in GetStorage");
    }
  }

  // Fetch or create chatId
  Future<void> getChatId() async {
    if (friendId == null || userId == null) {
      throw Exception("friendId or userId is null");
    }

    // Query to check if a chat room already exists
    final querySnapshot =
        await chats
            .where('users.$friendId', isNull: false)
            .where('users.$userId', isNull: false)
            .limit(1)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      chatId = querySnapshot.docs.single.id;
    } else {
      // Create a new chat room
      final docRef = await chats.add({
        'users': {friendId: friendId, userId: userId},
        'friend_name': friendName,
        'user_name': userName,
        'toId': userId,
        'fromId': friendId,
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': '',
      });
      chatId = docRef.id;
    }
  }

  // Send a message
  void sendMessage(String msg) async {
    if (msg.trim().isNotEmpty && chatId != null) {
      // Update the chat room with the last message
      await chats.doc(chatId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': userId,
      });

      // Add the message to the messages subcollection
      await chats.doc(chatId).collection("messages").add({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': userId,
      });

      messageController.clear();
    }
  }

  // Get messages stream
  Stream<QuerySnapshot> getChats(String chatId) {
    if (chatId == null) {
      throw Exception("chatId is null");
    }
    return chats.doc(chatId).collection("messages").orderBy('created_on').snapshots();
  }
}
