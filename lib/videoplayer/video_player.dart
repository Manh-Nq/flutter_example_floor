import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/animate/elements.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/videoplayer/player_provider.dart';
import 'package:video_player/video_player.dart';

import '../animate/Video.dart';
import '../animate/example_mini_player.dart';
import '../animate/video_card.dart';

class VideoPLayerScreen extends StatelessWidget {
  const VideoPLayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PlayerManager(),
        child: MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late ScrollController scrollController;
  double topPadding = 0;
  double oldTop = 0;
  double heightView = 0;
  double widthView = 0;
  late AnimationController animationController;

  late double _dragHeight;

  late Animation<double> animation;

  @override
  void initState() {
    context.read<PlayerManager>().init();
    scrollController = ScrollController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    animation = Tween<double>(begin: oldTop, end: topPadding)
        .animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightView = MediaQuery.of(context).size.height;
    widthView = MediaQuery.of(context).size.width;
    var controller = context.read<PlayerManager>().controller;

    // notify("[animation.value]${animation.value}");
    return Stack(
      children: <Widget>[
        Navigator(
          onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) => FirstScreen(),
          ),
        ),
        AnimatedPositioned(
            top: animation.value,
            left: 0,
            bottom: 0,
            right: 0,
            duration: Duration(milliseconds: 150),
            child: _videoScreenHome(controller, scrollController))
      ],
    );
  }

  Widget _videoScreenHome(
      VideoPlayerController controller, ScrollController scrollController) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Column(children: [
              GestureDetector(
                child: _playerView(controller, scrollController),
                onHorizontalDragUpdate: (offset) {
                  setState(() {
                    _calculate(offset.localPosition.dy);
                  });
                },
                onHorizontalDragEnd: (details) {
                  _calculatorUp(topPadding);
                },
              ),
              Expanded(child: Container(color: Colors.red))
            ])),
        navigationBar(),
      ],
    );
  }

  Widget _playerView(
      VideoPlayerController controller, ScrollController scrollController) {
    var percent = topPadding / heightView;

    var height = lerpDouble(200, 56, percent);
    var width = lerpDouble(widthView, 120, percent);
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        // Row(
        //   children: [
        //     Column(
        //       children: const [
        //         Text(
        //           "this is content video",
        //           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        //         ),
        //         Text("robert fukuda",
        //             style:
        //             TextStyle(fontSize: 12, fontWeight: FontWeight.w200)),
        //       ],
        //     ),
        //     const Icon(
        //       Icons.play_arrow,
        //       size: 32,
        //     ),
        //
        //     IconButton(
        //         onPressed: () {},
        //         icon: const Icon(
        //           Icons.close,
        //           size: 32,
        //         )),
        //   ],
        // ),
        GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
            setState(() {});
          },
          child: Container(
            height: height,
            width: width,
            child: VideoPlayer(controller),
          ),
        )
      ],
    );
  }

  void _calculate(double dy) {
    notify("[DY] $dy");
    setState(() {
      oldTop = topPadding;
      if (dy < 0) {
        notify("[DY<0] $dy");
        topPadding = 0;
      } else {
        if (dy > (heightView - 248)) {
          notify("[DY>238] $dy");
          topPadding = heightView - 248;
        } else {
          notify("[DY - Accept] $dy");
          topPadding = dy;
        }
      }
    });
    animation = Tween<double>(begin: oldTop, end: topPadding)
        .animate(animationController);
    animationController.forward();
  }

  void _calculatorUp(double offset) {
    // notify("[topPadding] $topPadding");

    setState(() {
      oldTop = topPadding;
      if (offset <= heightView / 2) {
        topPadding = 0;
      } else {
        topPadding = heightView;
      }
    });
    animation = Tween<double>(begin: oldTop, end: topPadding)
        .animate(animationController);
    animationController.forward();
  }
}
