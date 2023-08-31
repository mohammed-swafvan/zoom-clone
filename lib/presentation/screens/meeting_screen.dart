import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/utils/custom_size.dart';
import 'package:zoom_clone/presentation/widgets/home_meeting_button.dart';
import 'package:zoom_clone/services/jitsi_meet_methods.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JitsiMeetMethods jitsiMeetMethods = JitsiMeetMethods();

  Future<void> createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    await jitsiMeetMethods.creatMeeting(
      roomName: roomName,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSize.height10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetinButton(
              onTap: createNewMeeting,
              icon: Icons.videocam,
              text: 'New Meet',
            ),
            HomeMeetinButton(
              onTap: () {},
              icon: Icons.add_box_rounded,
              text: 'Join Meet',
            ),
            HomeMeetinButton(
              onTap: () {},
              icon: Icons.calendar_today,
              text: 'Schedule',
            ),
            HomeMeetinButton(
              onTap: () {},
              icon: Icons.arrow_upward_rounded,
              text: 'Share Screen',
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meeting with just a click!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
