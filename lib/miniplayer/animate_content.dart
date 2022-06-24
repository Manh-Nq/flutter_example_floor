import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

final _navigatorKey = GlobalKey();

class AnimatedContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Stack(
      children: <Widget>[
        Navigator(
          key: _navigatorKey,
          onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) => FirstScreen(),
          ),
        ),
        Miniplayer(
          minHeight: 70,
          maxHeight: height,
          builder: (height, percentage) => Center(
            child: Text('$height, $percentage'),
          ),
        ),
      ],
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo: FirstScreen')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Open SecondScreen'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Open ThirdScreen with root Navigator'),
            ),
          ],
        ),
      ),
    );
  }
}
