import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_clone/presentation/screens/history_meeting_screen.dart';
import 'package:zoom_clone/presentation/screens/meeting_screen.dart';
import 'package:zoom_clone/presentation/screens/settings_screen.dart';
import 'package:zoom_clone/presentation/utils/custom_colors.dart';
import 'package:zoom_clone/provider/bottom_nav_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MeetingScreen(),
      HistoryMeetingScreen(),
      const Text('Contact'),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Meet & Chat',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundColor,
      ),
      body: Consumer<BottomNavProvider>(
        builder: (context, value, _) {
          return pages[value.page];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(builder: (context, value, _) {
        return BottomNavigationBar(
          currentIndex: value.page,
          backgroundColor: CustomColor.footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            value.onPageChanged(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.comment_bank),
              label: 'Meet & Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'Meetings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        );
      }),
    );
  }
}
