import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rablo_chat/app/common/colors.dart';
import '../../../TextFile/textStyles.dart';
import '../../../common/inputFeild.dart';
import '../../../common/submitButton.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextStyles(
                color: Color(0xff5c23f6),
                text: "Welcome Back!",
                font_Weight: FontWeight.w600,
                size: 28.sp,
              ),
              InputFeild(
                keyType: TextInputType.emailAddress,
                mobileNumber: controller.email,
                icon: Icons.email,
                maxInput: 30,
                name: 'Email Id',
                // errorText: 'Email Id is not valid',
              ),
              SizedBox(height: 12.h),
              InputFeild(
                keyType: TextInputType.number,
                mobileNumber: controller.mobileNumber,
                icon: Icons.phone_android,
                name: 'Mobile Number',
                // errorText: 'Mobile Number is not valid',
              ),
              SizedBox(height: 12.h),

              ElevatedButton(
                onPressed: () {
                  controller.userLogin();
                },
                style: ElevatedButton.styleFrom(backgroundColor: AllColor.appBarColor),
                child: TextStyles(
                  color: Colors.white,
                  text: "Login",
                  font_Weight: FontWeight.w300,
                  size: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/register');
                },
                child: SubmitButton(text: "SignUp"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
