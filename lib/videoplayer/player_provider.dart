import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:video_player/video_player.dart';

class PlayerManager extends ChangeNotifier {
  late VideoPlayerController controller;

  // bool isPlay = false;

  void init() {
      controller =
          VideoPlayerController.asset('assets/videos/video_test01.mp4');
      controller.addListener(() {
      });

      controller.initialize().then((value) {
        // notify("initialize");
      });
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