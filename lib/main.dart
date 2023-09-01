import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zoom_clone/presentation/screens/home_screen.dart';
import 'package:zoom_clone/presentation/screens/login_screen.dart';
import 'package:zoom_clone/presentation/screens/video_call_screen.dart';
import 'package:zoom_clone/presentation/utils/custom_colors.dart';
import 'package:zoom_clone/provider/bottom_nav_provider.dart';
import 'package:zoom_clone/provider/video_call_provider.dart';
import 'package:zoom_clone/services/auth_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => VideoCallProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zoom Clone',
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: CustomColor.backgroundColor,
        ),
        routes: {
          '/login': (context) => const LogInScreen(),
          '/home': (context) => const HomeScreen(),
          '/video-call':(context) => const VideoCallScreen(),
        },
        home: StreamBuilder(
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
        ),
      ),
    );
  }
}
