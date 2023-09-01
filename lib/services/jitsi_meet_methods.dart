import 'package:flutter/material.dart';
import 'package:omni_jitsi_meet/feature_flag/feature_flag.dart' as feature_flag;
import 'package:omni_jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/services/auth_methods.dart';
import 'package:zoom_clone/services/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods authMethods = AuthMethods();
  final FirestoreMethods firestoreMethods = FirestoreMethods();

  Future<void> creatMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String? name;

      feature_flag.FeatureFlag featureFlag = feature_flag.FeatureFlag();
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

      if (username.isEmpty) {
        name = authMethods.user.displayName;
      } else {
        name = username;
      }

      final options = JitsiMeetingOptions(
        room: roomName,
        userDisplayName: name,
        userEmail: authMethods.user.email,
        userAvatarURL: authMethods.user.photoURL,
        audioMuted: isAudioMuted,
        videoMuted: isVideoMuted,
      );
      firestoreMethods.addToMeetingHistory(meetingName: roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
