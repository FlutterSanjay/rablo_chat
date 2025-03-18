import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/user/users.dart';

class RegisterController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  //TODO: Implement RegisterPageController
  TextEditingController nameFeild = TextEditingController();
  TextEditingController mobileFeild = TextEditingController();
  TextEditingController emailFeild = TextEditingController();

  final count = 0.obs;

  @override
  void onInit() {
    userCollection = firestore.collection("users"); // collection mean table
    super.onInit();
  }

  addUsers() async {
    try {
      if (nameFeild.text.isEmpty || mobileFeild.text.isEmpty || emailFeild.text.isEmpty) {
        Get.snackbar("Error", "All fields are required", colorText: Colors.red);
        return;
      } else {
        DocumentReference doc = userCollection.doc();
        Users users = Users(
          id: doc.id,
          name: nameFeild.text,
          email: emailFeild.text,
          number: mobileFeild.text,
        );

        // convert the product into json
        final usersJson = users.toJson();

        doc.set(usersJson);

        Get.snackbar("Success", "Data Added Successfully");

        nameFeild.clear();
        mobileFeild.clear();
        emailFeild.clear();

        Get.offAllNamed('/home-page');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
