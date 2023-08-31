import 'package:flutter/material.dart';
import 'package:omni_jitsi_meet/feature_flag/feature_flag.dart' as feature_flag;
import 'package:omni_jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/services/auth_methods.dart';

class JitsiMeetMethods {
  final AuthMethods authMethods = AuthMethods();

  Future<void> creatMeeting({required String roomName, required bool isAudioMuted, required bool isVideoMuted}) async {
    try {
      feature_flag.FeatureFlag featureFlag = feature_flag.FeatureFlag();
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

      final options = JitsiMeetingOptions(
        room: roomName,
        userDisplayName: authMethods.user.displayName,
        userEmail: authMethods.user.email,
        userAvatarURL: authMethods.user.photoURL,
        audioMuted: isAudioMuted,
        videoMuted: isVideoMuted,
      );
      JitsiMeetingResponse response = await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
