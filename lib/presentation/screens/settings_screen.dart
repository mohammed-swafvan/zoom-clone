import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/widgets/custom_botton.dart';
import 'package:zoom_clone/services/auth_methods.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      text: 'Log Out',
      onTap: () => AuthMethods().signOut(),
    );
  }
}
