import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlite_demo/database/user_database.dart';
import 'package:sqlite_demo/database/user_entity.dart';
import 'package:sqlite_demo/database/userdao.dart';
import 'package:sqlite_demo/extension.dart';

import 'dart:math';
import 'package:sqlite_demo/preferences/shared_preferences.dart';
import 'package:sqlite_demo/provider/screen/screen_count.dart';
import 'package:sqlite_demo/provider/screen/screen_count_comsumer.dart';
import 'package:sqlite_demo/provider/screen/screen_count_mutil_provider.dart';
import 'package:sqlite_demo/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserDatabase db =
      await $FloorUserDatabase.databaseBuilder(user_table_name).build();
  final dao = db.userDao;
  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget {
  UserDao dao;

  MyApp(this.dao);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(dao),
    );
  }
}

class HomePage extends StatefulWidget {
  UserDao dao;

  HomePage(this.dao);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc bloc = UserBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<User>> users = widget.dao.getAllUsers();
    users.asBroadcastStream().listen((event) {
      notify("$event");
    });
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
              StreamBuilder(
                  stream: users,
                  builder: (context, data) => Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          data.hasData
                              ? "user : ${(data.data as List<User>).length}"
                              : "user: 0",
                          style: const TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      )),
              StreamBuilder(
                  stream: bloc.nameStream,
                  builder: (context, data) => Text(
                      data.hasData ? data.data.toString() : "null",
                      style: const TextStyle(
                          fontSize: 20, color: Colors.deepOrange))),
              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: SizedBox(
                      width: 150,
                      height: 56,
                      child: ElevatedButton(
                          onPressed: () async {
                            bloc.deleteUser(widget.dao);
                          },
                          child: Text(
                            "delete",
                            style: TextStyle(color: Colors.amberAccent),
                          )))),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScreenCount()));
                  },
                  child: Text("go to screen counter")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenConsumer()));
                  },
                  child: Text("go to screen Consumer")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenMutilScreen()));
                  },
                  child: Text("go to screen Multi Provider")),
            ],
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.insertUser(widget.dao);
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
