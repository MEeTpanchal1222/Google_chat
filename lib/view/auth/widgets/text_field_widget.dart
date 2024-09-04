import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controler/auth_controller.dart';

class SignTextField extends StatefulWidget {
  final String hintText;
  final Auth_Controller controller;
  final TextEditingController textEditingController;
  final Icon prefixIcon;

  const SignTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.textEditingController,
  });

  @override
  State<SignTextField> createState() => _SignTextFieldState();
}

class _SignTextFieldState extends State<SignTextField> {
  @override
  Widget build(BuildContext context) {
    final Auth_Controller auth_controller = Get.put(Auth_Controller());
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30.0.h, vertical: 5.h),
      child: Container(
        height: 40.h,
        width: 300.h,
        padding:  EdgeInsets.only(left: 5.h),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10).r),
        child: TextField(
          controller: widget.textEditingController,
          obscureText: (widget.controller.isShowPwd.value)?true:false,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: (widget.hintText == 'Password')
                ? Obx(
                  ()=> GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.controller.showPassword();
                      widget.controller.update();
                    });
                  },
                  child: (widget.controller.isShowPwd.value)
                      ? const Icon(Icons.visibility_off)
                      :const Icon(Icons.remove_red_eye_sharp) ),
            )
                : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 12).h,
          ),
        ),
      ),
    );
  }
}