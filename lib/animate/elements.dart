import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:sqlite_demo/animate/video_card.dart';
import 'package:sqlite_demo/videoplayer/player_provider.dart';
import 'package:video_player/video_player.dart';

import '../extension.dart';
import 'Video.dart';

Widget videoScreen(
    MiniplayerController provider,
    double percentage,
    double width,
    ScrollController scrollController,
    PlayerManager playerManager,
    VoidCallback callback) {
  var videos = fakeItems();

  double? _height = lerpDouble(70, 220, percentage);
  double? _width = calculateWidth(width, percentage);

  double? opacity = calculateOpacity(percentage);
  double? opacityList = lerpDouble(0.0, 1.0, percentage);

  return Column(
    children: [
      Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          contentVideoMini(playerManager, opacity, () {
            callback();
          }),
          GestureDetector(
            onTap: () {
              notify("click video");
              // provider.animateToHeight(state: PanelState.MIN);
              if (playerManager.controller.value.isPlaying) {
                playerManager.pause();
              } else {
                playerManager.play();
              }
            }, // Image tapped
            child: Container(
                height: _height, width: _width, child: VideoPlayer(playerManager.controller)),
          ),
        ],
      ),
      Expanded(
          flex: 1,
          child: listVideos(videos, scrollController, opacityList ?? 0.0))
    ],
  );
}

Widget iconViews() {
  return Row(
    children: [
      IconExpand(1, Icons.link_off),
      IconExpand(1, Icons.share),
      IconExpand(1, Icons.download),
      IconExpand(1, Icons.cut),
      IconExpand(1, Icons.save_alt),
    ],
  );
}

Widget contentVideoMini(
    PlayerManager playerManager, double opacity, VoidCallback callback) {
  return Padding(
    padding: const EdgeInsets.only(left: 150),
    child: Opacity(
        opacity: opacity,
        child: Row(
          children: [
            Column(
              children: const [
                Text(
                  "this is content video",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text("robert fukuda",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w200)),
              ],
            ),
            IconButton(
                onPressed: () {
                  if (playerManager.controller.value.isPlaying) {
                    playerManager.pause();
                  } else {
                    playerManager.play();
                  }
                  callback();
                },
                icon: Icon(
                  playerManager.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                )),
            IconButton(onPressed: () {}, icon: Icon(Icons.close)),
          ],
        )),
  );
}

Widget navigationBar(BuildContext context) {
  double fw = MediaQuery.of(context).size.width;
  double w = fw / 5;
  return Container(
      color: Colors.white,
      width: fw,
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          IconNav(1, Icons.home, w),
          IconNav(1, Icons.short_text_outlined, w),
          IconNav(1, Icons.add, w),
          IconNav(1, Icons.subscriptions, w),
          IconNav(1, Icons.video_library, w),
        ],
      ));
}

Widget content() {
  return const Padding(
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
    child: Text(
      "Tập thể dục buổi sáng, Gà trống mèo con Cún con - Liên khúc nhạc thiếu nhi",
      maxLines: 2,
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget listVideos(
    List<Video> videos, ScrollController scrollController, double opacity) {
  return Scrollbar(
      child: Opacity(
          opacity: opacity,
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              var item = videos[index];
              if (item.type == Type.header) {
                return headerItem();
              } else {
                return VideoCard(video: videos[index]);
              }
            },
            itemCount: videos.length,
          )));
}

Widget headerItem() {
  return Container(
    width: double.infinity,
    alignment: Alignment.topLeft,
    height: 80,
    child: Column(
      children: [
        const Text("But if you want to change the opacity of all the widget, in your case a Container, you can wrap it into a Opacity widget like this",
            style: TextStyle(fontSize: 18), textAlign: TextAlign.left, maxLines: 2,overflow: TextOverflow.ellipsis,),
        Expanded(child: iconViews(), flex: 1),
      ],
    ),
  );
}
