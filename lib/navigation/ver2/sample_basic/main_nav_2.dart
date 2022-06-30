import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';

import '../../model/user.dart';

void main() {
  runApp(MyApp());
}

const String SCREEN_2_ROUTE = "sreen2";

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _screenRoute;

  void _onChange(String? route) {
    setState(() => _screenRoute = route);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Navigator(
      pages: [
        MaterialPage(child: UsersHome(
          didSelectUser: (id) {
            _onChange(id);
          },
        )),
        if (_screenRoute != null && _screenRoute != SCREEN_2_ROUTE)
          MaterialPage(
              child: UserDetailsView(
                id: _screenRoute,
                callback: (value) {
                  _onChange(value);
                },
              ),
              key: UserDetailsView.valueKey),
        if (_screenRoute == SCREEN_2_ROUTE)
          MaterialPage(child: Screen2(), key: Screen2.valueKey)
      ],
      onPopPage: (route, result) {
        final page = route.settings as MaterialPage;

        notify("${page.key}");

        if (page.key == UserDetailsView.valueKey) {
          _screenRoute = null;
        }

        var isPop = route.didPop(result);
        return isPop;
      },
    ));
  }
}

class UsersHome extends StatelessWidget {
  final ValueChanged didSelectUser;

  UsersHome({required this.didSelectUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Users')),
        body: Column(
          children: [
            featureButton(() {
              didSelectUser(SCREEN_2_ROUTE);
            }, "go to setting"),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                        child: ListTile(
                      title: Text(user.id),
                      onTap: () => didSelectUser(user.id),
                    ));
                  }),
            )
          ],
        ));
  }
}

class UserDetailsView extends StatelessWidget {
  static const valueKey = ValueKey('UserDetailsView');

  final String? id;
  final ValueChanged callback;

  UserDetailsView({this.id, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: Center(
            child: Column(
          children: [
            featureButton(() {
              callback(SCREEN_2_ROUTE);
            }, "go to Settings"),
            Text('Hello, $id')
          ],
        )));
  }
}

class Screen2 extends StatelessWidget {
  static const valueKey = ValueKey('Screen2');

  Screen2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Screen Settings",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

Widget featureButton(VoidCallback callback, String txt) {
  return ElevatedButton(
      onPressed: () {
        callback();
      },
      child: Text(txt));
}
