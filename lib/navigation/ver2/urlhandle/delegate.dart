import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/navigation/ver2/urlhandle/user_route.dart';
import 'package:sqlite_demo/navigation/model/user.dart';

import '../main_nav_2_route.dart';

class UserDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  String? _screenRoute;
  bool showErr = false;

  void _onChange(String? id) {
    _screenRoute = id;
    notifyListeners();
  }

  @override
  UserRoutePath? get currentConfiguration {
    if (showErr) return UserRoutePath.unknown();

    if (_screenRoute == null) return UserRoutePath.home();

    return UserRoutePath.details(id:_screenRoute);
  }

  User? getUserByID(String id) {
    User? item;
    users.forEach((element) {
      if (element.id == id) {
        item = element;
      }
    });
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(key: navigatorKey,
      pages: [
        MaterialPage(child: UsersHome(
          didSelectUser: (id) {
            _onChange(id);
          },
        )),
        if (_screenRoute != null)
          MaterialPage(
              child: UserDetailsView(id: _screenRoute),
              key: UserDetailsView.valueKey)
      ],
      onPopPage: (route, result) {
        final page = route.settings as MaterialPage;

        if (page.key == UserDetailsView.valueKey) {
          _onChange(null);
        }
        var isPop = route.didPop(result);
        return isPop;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(UserRoutePath path) async {

    pushLog("$path", "setNewRoutePath");

    if (path.isUnknown) {
      _screenRoute = null;
      showErr = true;
      // have an empty return to end the function
      return;
    }

    if (path.isDetailsPage) {
      if (int.parse(path.id ?? "-1") < 0) {
        showErr = true;
        return;
      }
      _screenRoute = path.id;
    } else {
      _screenRoute = null;
    }

    showErr = false;
  }
}
