import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/provider/CounterProvider.dart';
import 'package:sqlite_demo/provider/TextChangeProvider.dart';

class ScreenMutilScreen extends StatelessWidget {
  const ScreenMutilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => TextChangeProvider())
      ],
      child: ScreenMutilPage(),
    );
  }
}

class ScreenMutilPage extends StatefulWidget {
  const ScreenMutilPage({Key? key}) : super(key: key);

  @override
  State<ScreenMutilPage> createState() => _ScreenMutilPagePageState();
}

class _ScreenMutilPagePageState extends State<ScreenMutilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen Consummer"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.watch<CounterProvider>().count.toString(),
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    context.watch<TextChangeProvider>().name.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<TextChangeProvider>().setName();
                      },
                      child: Text("changeText")),
                  Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<CounterProvider>().plusCounter();
                          },
                          child: Text("change number")))
                ],
              )
            ],
          )),
    );
  }
}
