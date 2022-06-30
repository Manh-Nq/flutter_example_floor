import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/navigation/ver2/urlhandle/user_route.dart';

class UserRouteInfomationParser extends RouteInformationParser<UserRoutePath> {
  @override
  Future<UserRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    var uri = Uri.parse(routeInformation.location ?? "");

    pushLog("[Uri] $uri [location] ${routeInformation.location ?? " "}", "Information");

    if (uri.pathSegments.isEmpty) return UserRoutePath.home();

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments.first != 'book') return UserRoutePath.unknown();
      final id = uri.pathSegments.elementAt(1);
      return UserRoutePath.details(id: id);
    }

    return UserRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(UserRoutePath path) {

    pushLog(path.toString(), "restoreRouteInformation");

    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return null;
  }
}
