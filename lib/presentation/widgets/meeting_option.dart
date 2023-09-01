import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/utils/custom_colors.dart';

class MeetingOption extends StatelessWidget {
  const MeetingOption({super.key, required this.text, required this.isMute, required this.onChanged});

  final String text;
  final bool isMute;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: CustomColor.secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
          Switch.adaptive(
            value: isMute,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
