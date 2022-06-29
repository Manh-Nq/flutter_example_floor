import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_demo/database/user_database.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/userscreen/user_bloc.dart';

import '../database/user_entity.dart';

class UserScreen extends StatelessWidget {
  final UserDatabase db;

  UserScreen(this.db);

  @override
  Widget build(BuildContext context) {
    return UserHome(db);
  }
}

class UserHome extends StatefulWidget {
  final UserDatabase db;

  UserHome(this.db);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late UserBloc bloc;
  late ScrollController controller;

  @override
  void initState() {
    bloc = UserBloc(widget.db);
    bloc.initData();
    controller = ScrollController()
      ..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Screen User")), body: bodyUser());
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {});
    }
  }

  Widget bodyUser() {
    return Container(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  featureButton(() {
                    bloc.deleteAll();
                  }, "delete"),
                  featureButton(() {
                    bloc.insertUser();
                  }, "add User"),
                  featureButton(() {
                    bloc.getUserByID(22224197);
                  }, "find")
                ]),

            StreamBuilder(
                stream: bloc.userStream,
                builder: (context, data) {
                  var items = data.hasData == true
                      ? (data.data as List<User>)
                      : List.empty();

                  notify(items.toString());

                  return Expanded(
                    flex: 1,
                    child: Scrollbar(
                      child: Column(
                        children: [
                          Text(
                            "user :${items.length}",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                          Expanded(
                              flex: 1,
                              child: ListView.builder(
                                controller: controller,
                                itemBuilder: (context, index) {
                                  return userItemView(() {
                                    bloc.deleteUserByID(
                                        (items[index] as User).id);
                                  }, (user) {
                                    //update
                                    notify(user.name);
                                    bloc.update(user.id);
                                  },
                                      items[index],
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      Random().nextInt(10) / 10);
                                },
                                itemCount: items.length,
                              )),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ));
  }

  Widget featureButton(VoidCallback func, String txt) {
    return ElevatedButton(
        onPressed: () {
          func();
        },
        child: Text(txt));
  }

  Widget userItemView(VoidCallback func, ActionCallback action, User user,
      double width, double alpha) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
            child: Container(
              width: width,
              padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  Text(user.date,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
            )),
        GestureDetector(
          onTap: () {
            func();
          }, // Image tapped
          child: Container(
            child: Icon(Icons.restore_from_trash),
            padding: const EdgeInsets.only(right: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            action(user);
          }, // Image tapped
          child: Container(
            child: Icon(Icons.update),
            padding: const EdgeInsets.only(right: 16),
          ),
        ),
      ],
    );
  }
}

typedef ActionCallback = void Function(User user);
