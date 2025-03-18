import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rablo_chat/app/TextFile/textStyles.dart';
import '../../../common/colors.dart';
import '../../../common/inputFeild.dart';
import '../../../common/submitButton.dart';
import '../../../common/submmitedButton.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Center(
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(text: "By continuing, You agree our "),
                TextSpan(
                  text: "Terms and Service ",
                  style: TextStyle(
                    decorationColor: CupertinoColors.activeBlue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextStyles(
                color: AllColor.appBarColor,
                text: "Create Your Account !!",
                font_Weight: FontWeight.bold,
                size: 28.sp,
              ),
              InputFeild(
                keyType: TextInputType.text,
                mobileNumber: controller.emailFeild,
                icon: Icons.email,
                name: 'Email Address',
                maxInput: 20,
                // errorText: "Please ensure the name is no longer than 20 characters.",
              ),

              InputFeild(
                keyType: TextInputType.number,
                mobileNumber: controller.mobileFeild,
                icon: Icons.phone_android,
                name: 'Mobile number',
                // errorText: 'Mobile Number must be Correct',
              ),
              InputFeild(
                keyType: TextInputType.text,
                mobileNumber: controller.nameFeild,
                icon: Icons.contact_page_rounded,
                name: 'Your Name',
                maxInput: 20,
                // errorText: "Please ensure the name is no longer than 20 characters.",
              ),
              SizedBox(height: 15.h),

              SubmittingButton(text: "Sign Up", controller: controller),
              SizedBox(height: 8.h),
              InkWell(
                onTap: () {
                  Get.offNamed('/login');
                },
                child: SubmitButton(text: "Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
