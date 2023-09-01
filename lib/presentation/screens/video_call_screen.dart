import 'package:flutter/material.dart';
import 'package:omni_jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';
import 'package:zoom_clone/presentation/utils/custom_colors.dart';
import 'package:zoom_clone/presentation/utils/custom_size.dart';
import 'package:zoom_clone/presentation/widgets/custom_text_field.dart';
import 'package:zoom_clone/presentation/widgets/meeting_option.dart';
import 'package:zoom_clone/provider/video_call_provider.dart';
import 'package:zoom_clone/services/auth_methods.dart';
import 'package:zoom_clone/services/jitsi_meet_methods.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods authMethods = AuthMethods();
  final JitsiMeetMethods jitsiMeetMethods = JitsiMeetMethods();

  @override
  void initState() {
    final provider = Provider.of<VideoCallProvider>(context, listen: false);
    provider.meetingIdController = TextEditingController();
    provider.nameController = TextEditingController(
      text: authMethods.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    final provider = Provider.of<VideoCallProvider>(context, listen: false);
    provider.meetingIdController.dispose();
    provider.nameController.dispose();
    JitsiMeet.closeMeeting();
    super.dispose();
  }

  joinMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    required String username,
  }) {
    jitsiMeetMethods.creatMeeting(
      roomName: roomName,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: username,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Join a Meeting'),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundColor,
      ),
      body: Column(
        children: [
          Consumer<VideoCallProvider>(
            builder: (context, value, _) {
              return CustomTextField(
                controller: value.meetingIdController,
                hintText: 'Room ID',
              );
            },
          ),
          Consumer<VideoCallProvider>(
            builder: (context, value, _) {
              return CustomTextField(
                controller: value.nameController,
                hintText: 'Name',
              );
            },
          ),
          CustomSize.height20,
          Consumer<VideoCallProvider>(
            builder: (context, value, _) {
              return InkWell(
                onTap: () {
                  joinMeeting(
                    roomName: value.meetingIdController.text,
                    isAudioMuted: value.isAudioMuted,
                    isVideoMuted: value.isVideoMuted,
                    username: value.nameController.text,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Join',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
          CustomSize.height20,
          Consumer<VideoCallProvider>(
            builder: (context, value, _) {
              return MeetingOption(
                text: 'Mute Audio',
                isMute: value.isAudioMuted,
                onChanged: value.onAudioMuted,
              );
            },
          ),
          Consumer<VideoCallProvider>(
            builder: (context, value, _) {
              return MeetingOption(
                text: 'Turn Off My Video',
                isMute: value.isVideoMuted,
                onChanged: value.onVideoMuted,
              );
            },
          ),
        ],
      ),
    );
  }
}
