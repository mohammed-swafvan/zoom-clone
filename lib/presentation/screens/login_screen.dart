// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/screens/home_screen.dart';
import 'package:zoom_clone/presentation/widgets/custom_botton.dart';
import 'package:zoom_clone/services/auth_methods.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthMethods authMethods = AuthMethods();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 35),
              child: Text(
                "Start or join a meeting",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Image.asset('assets/images/onboarding.jpeg'),
            ),
            CustomButtonWidget(
              text: 'Google Sign In',
              onTap: () async {
                bool res = await authMethods.signInWithGoogle(context);
                if (res) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
            ),
        
          ],
        ),
      ),
    );
  }
}
