import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/navigation/ver2/nested/screen/book_detail_screen.dart';
import 'package:sqlite_demo/navigation/ver2/nested/screen/book_list_screen.dart';
import 'package:sqlite_demo/navigation/ver2/nested/screen/setting_screen.dart';

import '../book_notify_changer.dart';
import '../model/book_route_path.dart';
import '../nested_screen.dart';

class InnerRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BooksAppState get appState => _appState;
  BooksAppState _appState;

  set appState(BooksAppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {

    notify("[BUILD] ${appState.selectedIndex}");

    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          MaterialPage(
            child: BooksListScreen(
              books: books,
              onTapped: _handleBookTapped,
            ),
            key: ValueKey('BooksListPage'),
          ),
          if (appState.selectedBook != null)
            MaterialPage(
              key: ValueKey(appState.selectedBook),
              child: BookDetailsScreen(book: appState.selectedBook??books[0]),
            ),
        ] else
          MaterialPage(child: SettingsScreen(),  key: ValueKey('SettingsPage'),)
      ],
      onPopPage: (route, result) {
        appState.selectedBook = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleBookTapped(Book book) {
    notify(book.author);

    appState.selectedBook = book;
    notifyListeners();
  }
}
