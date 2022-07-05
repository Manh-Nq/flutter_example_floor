import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/videoplayer/player_provider.dart';
import 'package:video_player/video_player.dart';

import '../animate/Video.dart';
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

class _HomeState extends State<Home> {
  late ScrollController scrollController;
  double _height = 200;
  late double _width = 0;

  @override
  void initState() {
    context.read<PlayerManager>().init();
    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.read<PlayerManager>().controller;
    return Stack(
      children: [_player(controller, scrollController)],
    );
  }

  Widget _player(
      VideoPlayerController controller, ScrollController scrollController) {
    return Scaffold(
        appBar: AppBar(title: const Text("Play Video")),
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: _bodyVideoScreen(controller, scrollController)),
            _navigationBar()
          ],
        ));
  }

  Widget _bodyVideoScreen(
      VideoPlayerController controller, ScrollController scrollController) {
    var videos = fakeItems();
    return Column(children: [
      Stack(
    children: [
      Container(
        height: _height,
        width: _width,
        child: Positioned(top: 0, left: 0, child: VideoPlayer(controller)),
      ),
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: IconButton(
            onPressed: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
              setState(() {});
            },
            icon: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 40,
            )),
      ),
    ],
      ),
      const Padding(
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
    child: Text(
      "Tập thể dục buổi sáng, Gà trống mèo con Cún con - Liên khúc nhạc thiếu nhi",
      maxLines: 2,
      style: TextStyle(fontSize: 16),
    ),
      ),
      _iconViews(),
      Expanded(
    flex: 1,
    child: Scrollbar(
        child: ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        return VideoCard(video: videos[index]);
      },
      itemCount: videos.length,
    )),
      ),
    ]);
  }

  Widget _iconViews() {
    double fw = MediaQuery.of(context).size.width;
    double w = fw / 5;
    return Container(
        width: fw,
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            IconExpand(1, Icons.share, w),
            IconExpand(1, Icons.account_box, w),
            IconExpand(1, Icons.dangerous, w),
            IconExpand(1, Icons.dark_mode, w),
            IconExpand(1, Icons.access_time_outlined, w),
          ],
        ));
  }

  Widget _navigationBar() {
    double fw = MediaQuery.of(context).size.width;
    double w = fw / 3;
    return Container(
        width: fw,
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            IconExpand(1, Icons.arrow_back_ios, w),
            IconExpand(1, Icons.home, w),
            IconExpand(1, Icons.multiple_stop, w),
          ],
        ));
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 500) {
      setState(() {});
    }
  }
}
