
import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/navigation/ver2/advanced/components/user_route.dart';
import 'package:sqlite_demo/navigation/model/user.dart';

import '../main_nav_2_route.dart';


class UserDelegate extends RouterDelegate<ScreenState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ScreenState> {
  String? _screenRoute;
  bool _showErr = false;

  void _onChange(String? id) {
    _screenRoute = id;
    notifyListeners();
  }

  @override
  ScreenState? get currentConfiguration {

    notify("currentConfiguration");

    if (_showErr) return ScreenState.err;

    if (_screenRoute == null) return ScreenState.home;
    if (_screenRoute == "settings") return ScreenState.settings;

    return  ScreenState.detail;
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
          onSelect: (id) {
            _onChange(id);
          },
        )),
        if (_screenRoute != null && _screenRoute!="settings")
          MaterialPage(
              child: UserDetailsView( _screenRoute, (value){
                _onChange(value);
              }),
              key: UserDetailsView.valueKey)
        else if(_screenRoute != null && _screenRoute=="settings")
          MaterialPage(
              child: SettingScreen(  (){
               _onChange(null);
              }),
              key: SettingScreen.valueKey)
      ],
      onPopPage: (route, result) {
        final page = route.settings as MaterialPage;
        notify("$page");

        if (page.key == UserDetailsView.valueKey) {
          _onChange(null);
        }
        return route.didPop(result);
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(ScreenState state) async {
    //config
    notify("[setNewRoutePath] ${state.toString()}");
  }
}
