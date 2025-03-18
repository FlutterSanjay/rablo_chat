import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rablo_chat/app/data/allUser/all_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  GetStorage box = GetStorage();
  Future<SharedPreferences> sPref = SharedPreferences.getInstance();

  late CollectionReference allUser;
  var userList = <AllUsers>[].obs;
  RxBool isLoading = false.obs;
  // set the Selected Card Data
  Future<void> setCardData(int index) async {
    final SharedPreferences sp = await sPref;
    sp.setString("id", userList[index].id.toString());
    sp.setString("name", userList[index].name.toString());
    sp.setString("mobileNumber", userList[index].number.toString());
    sp.setString("email", userList[index].email.toString());
  }

  // Fetch Data from database
  fetchData() async {
    try {
      QuerySnapshot userSnapshot = await allUser.get();
      final List<AllUsers> users =
          userSnapshot.docs
              .map((doc) => AllUsers.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

      if (users.isNotEmpty) {
        userList.value = users;

        isLoading.value = true;
      } else {
        userList.clear(); // Clear the list if no products
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    allUser = firestore.collection("users");

    fetchData();
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
