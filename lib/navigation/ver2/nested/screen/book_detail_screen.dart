
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_demo/navigation/ver2/sample_basic/main_nav_2.dart';

import '../nested_main.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            featureButton(() {
                Navigator.of(context).pop();
              },
            'Back',
            ),
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}