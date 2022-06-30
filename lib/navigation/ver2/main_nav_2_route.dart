import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/navigation/ver2/urlhandle/delegate.dart';
import 'package:sqlite_demo/navigation/ver2/urlhandle/parse_infomation.dart';

import '../model/user.dart';

void main() {
  runApp(MyApp2());
}

// const String SCREEN_2 = "sreen2";

class MyApp2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  final _routerDelegate = UserDelegate();
  final _routeInformationParser = UserRouteInfomationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'User App',
      debugShowCheckedModeBanner: false,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser
    );
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

  UserDetailsView({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: Center(child: Text('Hello, $id')));
  }
}


Widget featureButton(VoidCallback callback, String txt) {
  return ElevatedButton(
      onPressed: () {
        callback();
      },
      child: Text(txt));
}
