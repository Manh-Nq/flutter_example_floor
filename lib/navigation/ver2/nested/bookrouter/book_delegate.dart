import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';

import '../book_notify_changer.dart';
import '../model/book_route_path.dart';
import '../nested_main.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  BooksAppState appState = BooksAppState();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  BookRoutePath get currentConfiguration {

    notify("[Bookdelegate Route]${appState.selectedIndex.toString()}");

    if (appState.selectedIndex == 1) {
      return BooksSettingsPath();
    } else {
      if (appState.selectedBook == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(appState.getSelectedBookById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: AppShell(appState: appState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appState.selectedBook != null) {
          appState.selectedBook = null;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {

    notify(path.toString());

    if (path is BooksListPath) {
      appState.selectedIndex = 0;
      appState.selectedBook = null;
    } else if (path is BooksSettingsPath) {
      appState.selectedIndex = 1;
    } else if (path is BooksDetailsPath) {
      appState.setSelectedBookById(path.id);
    }
  }
}