import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/utils/custom_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: controller,
        maxLines: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
          fillColor: CustomColor.secondaryBackgroundColor,
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
