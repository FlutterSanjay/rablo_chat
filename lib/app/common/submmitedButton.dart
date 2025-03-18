import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../TextFile/textStyles.dart';
import '../modules/register/controllers/register_controller.dart';

class SubmittingButton extends StatelessWidget {
  const SubmittingButton({super.key, required this.text, required this.controller});
  final String? text;
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.addUsers,

      style: ElevatedButton.styleFrom(backgroundColor: Color(0xff5c23f6)),
      child: TextStyles(
        color: Colors.white,
        text: text,
        font_Weight: FontWeight.w300,
        size: 14.sp,
      ),
    );
  }
}
