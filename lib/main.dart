import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlite_demo/database/user_database.dart';
import 'package:sqlite_demo/database/userdao.dart';
import 'package:sqlite_demo/main/user_screen.dart';
import 'package:sqlite_demo/preferences/shared_preferences.dart';

import 'package:sqlite_demo/provider/screen/screen_count.dart';
import 'package:sqlite_demo/provider/screen/screen_count_comsumer.dart';
import 'package:sqlite_demo/provider/screen/screen_count_mutil_provider.dart';

import 'animate/animate_screen.dart';
import 'main/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserDatabase db =
      await $FloorUserDatabase.databaseBuilder(user_table_name).build();
  runApp(MyApp(db));
}

class MyApp extends StatelessWidget {
  UserDatabase db;

  MyApp(this.db);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(db),
    );
  }
}

class HomePage extends StatefulWidget {
  UserDatabase db;

  HomePage(this.db);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserBloc bloc;

  @override
  void initState() {
    bloc = UserBloc(widget.db);
    bloc.initData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen Main")),
      body: Container(
          child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              featureButton(UserScreen(widget.db), "go to User screen"),
              featureButton(const ScreenCount(), "go to screen counter"),
              featureButton(const ScreenConsumer(), "go to screen Consumer"),
              featureButton(
                  const ScreenMutilScreen(), "go to screen Multi Provider"),
              featureButton(
                  const AnimatedContentScreen(), "go to screen Animated"),
              featureButton(
                  const ShareApp(), "go to screen Share"),
            ],
          ),
        ],
      )),
    );
  }

  Widget featureButton(Widget screen, String txt) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Text(txt));
  }
}
