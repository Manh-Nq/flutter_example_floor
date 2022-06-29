import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/animate/video_card.dart';

import '../extension.dart';
import 'Video.dart';

class AnimatedContentScreen extends StatelessWidget {
  const AnimatedContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MiniplayerController(),
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController controller;
  List<String> items = List.generate(100, (index) => 'Hello $index');

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<MiniplayerController>(
        builder: (context, provider, _) {
          return Stack(
            children: <Widget>[
              Navigator(
                onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
                  settings: settings,
                  builder: (BuildContext context) => FirstScreen(),
                ),
              ),
              Miniplayer(
                  controller: provider,
                  minHeight: 70,
                  maxHeight: height,
                  builder: (height, percentage) {
                    if (percentage == 0.0) {
                      return _ViewMini(context);
                    } else {
                      return _fullScreen(
                          provider, percentage, width, controller);
                    }
                  }),
            ],
          );
        },
      ),
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        items.addAll(List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }
}

Widget _fullScreen(MiniplayerController provider, double percentage,
    double width, ScrollController controller) {
  var videos = fakeItems();
  return Column(
    children: [
      Row(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  notify("click photo");
                  provider.animateToHeight(state: PanelState.MIN);
                }, // Image tapped
                child: Image.network(
                  "https://st2.depositphotos.com/1882291/7278/v/450/depositphotos_72782299-stock-illustration-tiger-illustration.jpg",
                  height: lerpDouble(56, 220, percentage),
                  width: lerpDouble(120, width, percentage),
                  fit: BoxFit.cover,
                  errorBuilder: (_,err,ss){
                    return Text("data");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      Expanded(
        flex: 1,
        child: Scrollbar(
            child: ListView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            return VideoCard(video: videos[index]);
          },
          itemCount: videos.length,
        )),
      ),
    ],
  );
}

Widget _ViewMini(BuildContext context) {
  return Container(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Image.network(
              "https://st2.depositphotos.com/1882291/7278/v/450/depositphotos_72782299-stock-illustration-tiger-illustration.jpg",
              height: 56.0,
              width: 120.0,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "Tiger",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Ngo manh",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );
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
              Text('animate Screen'),
            ]),
      ),
    );
  }
}
