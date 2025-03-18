import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:rablo_chat/app/common/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat App',
          style: TextStyle(
            color: AllColor.appBarColor,
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.setCardData(index);
                Get.toNamed('/chat-room');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Profile Picture
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person, color: AllColor.appBarColor),
                    ),
                    // Chat Details
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            controller.userList[index].name.toString(),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),

                          SizedBox(width: 8.0),
                          Text(
                            controller.userList[index].number.toString(),
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10.h);
          },
        ),
      ),
    );
  }
}
