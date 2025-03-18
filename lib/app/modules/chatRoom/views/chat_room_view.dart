import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rablo_chat/app/common/colors.dart';
import '../controllers/chat_room_controller.dart';

//
class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});

  //
  @override
  Widget build(BuildContext context) {
    // controller.getFriendId();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              // stream Builder apply
              child: FutureBuilder<QuerySnapshot>(
                future:
                    controller.chatId != null
                        ? controller.getChats(controller.chatId)
                        : null, // Ensure future is not null
                builder: (context, snapshot) {
                  // Handle loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Handle error state
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  // Handle empty state or null data
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages yet.'));
                  }

                  // Display messages using ListView.builder
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      return chatBubble(index, doc); // Ensure chatBubble is defined
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5, bottom: 5),
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: controller.messageController,
                        maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.emoji_emotions_rounded,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.attachment_rounded, color: Colors.grey),
                          border: InputBorder.none,
                          hintText: "Type Message here ...",
                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage(controller.messageController.text);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8, bottom: 5),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: AllColor.appBarColor,
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Message Input Field
          ],
        ),
      ),
    );
  }

  Directionality chatBubble(int index, DocumentSnapshot doc) {
    var t = doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
    var time = intl.DateFormat("h:mma").format(t);
    return Directionality(
      textDirection:
          doc['uid'] == controller.userId ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
                  doc['uid'] == controller.userId
                      ? AllColor.navBackgroundColor
                      : Colors.blue.withAlpha(30),
              child: Icon(Icons.person, color: Colors.black),
            ),
            SizedBox(height: 20),

            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: doc['uid'] == controller.userId ? Colors.cyan : Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text("${doc['msg']}", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),

            SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
