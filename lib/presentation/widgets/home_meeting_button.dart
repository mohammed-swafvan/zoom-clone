import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/utils/custom_colors.dart';
import 'package:zoom_clone/presentation/utils/custom_size.dart';

class HomeMeetinButton extends StatelessWidget {
  const HomeMeetinButton({super.key, required this.onTap, required this.icon, required this.text});
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: CustomColor.buttonColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.06), offset: const Offset(0, 4))],
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          CustomSize.height10,
          Text(
            text,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
