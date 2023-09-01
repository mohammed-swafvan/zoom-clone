import 'package:flutter/material.dart';

class VideoCallProvider extends ChangeNotifier {
  late TextEditingController meetingIdController;
  late TextEditingController nameController;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  onAudioMuted(bool value) {
    isAudioMuted = value;
    notifyListeners();
  }

  onVideoMuted(bool value) {
    isVideoMuted = value;
    notifyListeners();
  }
  
}
