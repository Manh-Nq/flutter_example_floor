import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqlite_demo/extension.dart';

import 'book_notify_changer.dart';
import 'bookrouter/book_delegate.dart';
import 'bookrouter/book_parser.dart';
import 'innerrouter/inner_delegate.dart';

class NestedScreen extends StatefulWidget {
  @override
  _NestedScreenState createState() => _NestedScreenState();
}

class _NestedScreenState extends State<NestedScreen> {

  final BookRouterDelegate _routerDelegate = BookRouterDelegate();

  final BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

// Widget that contains the AdaptiveNavigationScaffold
class AppShell extends StatefulWidget {
  final BooksAppState appState;

  AppShell({
    required this.appState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late InnerRouterDelegate _routerDelegate;
  late ChildBackButtonDispatcher? _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        ?.createChildBackButtonDispatcher()?..addCallback(() => _callback());
  }

  Future<bool> _callback() async {
    var back =widget.appState.backPress();
    return back;
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;

    _backButtonDispatcher?.takePriority();

    return Scaffold(
      appBar: AppBar(),
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: appState.selectedIndex,
        onTap: (newIndex) {
          appState.selectedIndex = newIndex;
        },
      ),
    );
  }
  @override
  void dispose() {
    _backButtonDispatcher?.removeCallback(() => _callback());
    super.dispose();
  }
}