import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class _HomeState extends State<Home> {
  late ScrollController scrollController;
  double _height = 200;
  late double _width = 0;

  @override
  void initState() {
    context.read<PlayerManager>().init();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    super.didChangeDependencies();
  }

  void _calculate(double offset) {
    setState(() {
      if (_height > 50) {
        _height -= offset;
      } else {
        _height = _height;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.read<PlayerManager>().controller;
    return Scaffold(
        appBar: AppBar(title: const Text("Play Video")),
        body: Stack(
          children: <Widget>[
            Navigator(
              onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => FirstScreen(),
              ),
            ),
            _videoScreenHome(controller, scrollController),
          ],
        ));
  }

  Widget _videoScreenHome(
      VideoPlayerController controller, ScrollController scrollController) {
    return Column(
      children: [
        Expanded(
            flex: 1, child: _bodyVideoScreen(controller, scrollController, 0)),
        _navigationBar()
      ],
    );
  }

  Widget _bodyVideoScreen(
      VideoPlayerController controller, ScrollController scrollController, double paddingTop) {
    var videos = fakeItems();
    return Column(children: [
      GestureDetector(
        child: _playerView(_width, _height, controller, scrollController),
        onHorizontalDragUpdate: (offset) {
          notify("[onHorizontalDragUpdate] ${offset.delta.toString()}");
          // _calculate(offset.delta.dy);
        },
        onVerticalDragUpdate: (offset) {
          notify("[onVerticalDragUpdate] ${offset.delta.toString()}");
        },
      ),
      _content(),
      _iconViews(),
      _listVideos(videos),
    ]);
  }

  Widget _playerView(double w, double h, VideoPlayerController controller,
      ScrollController scrollController) {
    notify("[PLAYER_VIEW] $h");
    return Stack(
      children: [
        Container(
          height: h,
          width: w,
          child: Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: VideoPlayer(controller)),
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
    );
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
            IconExpand(1, Icons.link_off),
            IconExpand(1, Icons.share),
            IconExpand(1, Icons.download),
            IconExpand(1, Icons.cut),
            IconExpand(1, Icons.save_alt),
          ],
        ));
  }

  Widget _navigationBar() {
    double fw = MediaQuery.of(context).size.width;
    double w = fw / 5;
    return Container(
        width: fw,
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            IconExpand(1, Icons.home),
            IconExpand(1, Icons.short_text_outlined),
            IconExpand(1, Icons.add),
            IconExpand(1, Icons.subscriptions),
            IconExpand(1, Icons.video_library),
          ],
        ));
  }

  Widget _content() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      child: Text(
        "Tập thể dục buổi sáng, Gà trống mèo con Cún con - Liên khúc nhạc thiếu nhi",
        maxLines: 2,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _listVideos(List<Video> videos) {
    return Expanded(
      flex: 1,
      child: Scrollbar(
          child: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          return VideoCard(video: videos[index]);
        },
        itemCount: videos.length,
      )),
    );
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 500) {
      setState(() {});
    }
  }
}
