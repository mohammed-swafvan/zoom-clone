import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/screens/login_screen.dart';
import 'package:zoom_clone/presentation/widgets/custom_botton.dart';
import 'package:zoom_clone/services/auth_methods.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      text: 'Log Out',
      onTap: () {
        showAdaptiveDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog.adaptive(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(); // Close the dialog
                    await performLogOut(context);
                  },
                  child: const Text('Log Out'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> performLogOut(BuildContext context) async {
    bool res = await AuthMethods().signOut();
    if (res) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LogInScreen(),
          ),
        );
      }
    }
  }
}
