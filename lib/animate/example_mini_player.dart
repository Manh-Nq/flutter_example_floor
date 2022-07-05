import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/animate/video_card.dart';
import 'package:sqlite_demo/videoplayer/player_provider.dart';
import 'package:video_player/video_player.dart';

import '../extension.dart';
import 'Video.dart';
import 'elements.dart';

class AnimatedContentScreen extends StatelessWidget {
  const AnimatedContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MiniplayerController()),
        ChangeNotifierProvider(create: (context) => PlayerManager())
      ],
      child: MaterialApp(home: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController scrollController;
  List<String> items = List.generate(100, (index) => 'Hello $index');

  @override
  void initState() {
    context.read<PlayerManager>().init();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var controller = context.read<PlayerManager>().controller;

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Consumer<MiniplayerController>(
            builder: (context, provider, _) {
              return Stack(
                children: <Widget>[
                  FirstScreen(),
                  Miniplayer(
                      controller: provider,
                      minHeight: 70,
                      maxHeight: height,
                      builder: (height, percentage) {
                        return videoScreen(provider, percentage, width,
                            scrollController, controller, () {
                          setState(() {});
                        });
                      }),
                ],
              );
            },
          ),
        ),
        navigationBar(context)
      ],
    ));
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo: FirstScreen')),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('video Screen'),
            ]),
      ),
    );
  }
}
