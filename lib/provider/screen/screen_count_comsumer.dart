import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/provider/CounterProvider.dart';

class ScreenConsumer extends StatelessWidget {
  const ScreenConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: ScreenConsumerPage(),
    );
  }
}

class ScreenConsumerPage extends StatefulWidget {
  const ScreenConsumerPage({Key? key}) : super(key: key);

  @override
  State<ScreenConsumerPage> createState() => _ScreenConsumerPageState();
}

class _ScreenConsumerPageState extends State<ScreenConsumerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(builder: (context, provider, child) {
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
                      provider.count.toString(),
                      style: TextStyle(fontSize: 50),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          provider.plusCounter();
                        },
                        child: Text("plus")),
                    Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                            onPressed: () {
                              provider.minusCounter();
                            },
                            child: Text("minus")))
                  ],
                )
              ],
            )),
      );
    });
  }
}
