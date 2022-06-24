import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/provider/CounterProvider.dart';

class ScreenCount extends StatelessWidget {
  const ScreenCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: ScreenPage(),
    );
  }
}

class ScreenPage extends StatefulWidget {
  const ScreenPage({Key? key}) : super(key: key);

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen count")),
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
                  ElevatedButton(
                      onPressed: () {
                        context.read<CounterProvider>().plusCounter();
                      },
                      child: Text("plus")),
                  Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<CounterProvider>().minusCounter();
                          },
                          child: Text("minus")))
                ],
              )
            ],
          )),
    );
  }
}
