import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerManager extends ChangeNotifier {
  late VideoPlayerController controller;

  void init() {
    controller = VideoPlayerController.asset('assets/videos/video_test01.mp4')
      ..addListener(() {})
      ..initialize().then((value) {});
    controller.value = VideoPlayerValue(
        duration: Duration(milliseconds: 0), size: Size(100, 100));
    notifyListeners();
  }

  void seekTo(int seconds) {
    controller.seekTo(Duration(seconds: seconds));
  }

  void play() {
    controller.play();
  }

  void pause() {
    controller.pause();
  }
}
