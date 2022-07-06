import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';

class AnimatedPosScreen extends StatelessWidget {
  const AnimatedPosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool isLeftCollapsed = true;
  bool isRightCollapsed = true;
  bool isTopCollapsed = true;
  double topOffset = 0;
  bool isBottomCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 100);
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          upperBar(),
          sideBar(),
          bottomBar(),
          AnimatedPositioned(
              left: isLeftCollapsed ? 0 : 0.5 * screenWidth,
              right: isRightCollapsed ? 0 : -0.2 * screenWidth,
              top: topOffset,
              bottom: isBottomCollapsed ? 0 : 0.1 * screenHeight,
              duration: duration,
              child: Container(child: dashboard(context))),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Positioned(
        bottom: 10,
        left: 30,
        child: Row(
          children: [
            Text(
              "Reset Password",
              style: TextStyle(color: Colors.grey, fontSize: 25),
            ),
            SizedBox(
              width: 60,
            ),
            Container(
              width: 100,
              height: 40,
              child: Center(
                  child: Text(
                "Log Out",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
            )
          ],
        ));
  }

  Widget sideBar() {
    return Positioned(
        left: 30,
        top: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "My Account",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "My Orders",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Settings",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 25),
            ),
          ],
        ));
  }

  Widget upperBar() {
    return Positioned(
        top: 40,
        left: 30,
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.person_outline),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "User name",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 80,
            ),
            Container(
              width: 100,
              height: 40,
              child: Center(
                  child: Text(
                "View Profile",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
            )
          ],
        ));
  }

  Widget dashboard(context) {
    return GestureDetector(
      child: Container(
        color: Colors.red,
        height: 200,
      ),
      onTap: () {},
      onHorizontalDragUpdate: (offset) {
        setState(() {
          _calculator(offset.localPosition.dy);
        });
        // notify("globalPosition: ${offset.globalPosition.dy}");
      },
      onHorizontalDragEnd: (off) {
        _calculatorUp(topOffset);
      },
    );
  }

  void _calculator(double offset) {
    setState(() {
      if (offset > screenHeight - 200) {
        topOffset = screenHeight - 200;
      } else {
        topOffset = offset;
      }
    });
  }

  void _calculatorUp(double offset) {
    notify("[calculator]  ${screenHeight / 2}-- oldOffset: ${topOffset})");
    setState(() {
      if (offset <= screenHeight / 2) {
        topOffset = 0;
      } else {
        topOffset = screenHeight - 200;
      }
    });
  }
}
