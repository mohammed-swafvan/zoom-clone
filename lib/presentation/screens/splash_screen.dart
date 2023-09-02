// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/screens/home_screen.dart';
import 'package:zoom_clone/presentation/screens/login_screen.dart';
import 'package:zoom_clone/presentation/utils/custom_size.dart';
import 'package:zoom_clone/services/auth_methods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToMainPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                  'assets/images/zoom-logo.png',
                ),
              ),
              CustomSize.height20,
              const Text(
                'Zoom',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future goToMainPage() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthMethods().authChanges,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const LogInScreen();
      },
    );
  }
}
