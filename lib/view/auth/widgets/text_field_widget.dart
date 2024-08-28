import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: const Color(0xffF0F0F0),
            borderRadius: BorderRadius.circular(10)),
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
            contentPadding: const EdgeInsets.only(top: 12),
          ),
        ),
      ),
    );
  }
}