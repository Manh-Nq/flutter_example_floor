
import 'package:flutter/material.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/navigation/ver2/urlhandle/components/user_route.dart';
import 'package:sqlite_demo/provider/TextChangeProvider.dart';

class UserRouteInfomationParser extends RouteInformationParser<ScreenState> {
  @override
  Future<ScreenState> parseRouteInformation(
      RouteInformation routeInformation) async {
    var uri = Uri.parse(routeInformation.location ?? "");

     notify("[parseRouteInformation]  ${uri}");

    var pathSegment = uri.pathSegments;

    if (pathSegment.isEmpty) return ScreenState.home;

    if (pathSegment.length >= 2) {
      if (pathSegment.first == '404') return ScreenState.err;
      if (pathSegment.first == 'settings') return ScreenState.settings;

      return ScreenState.detail;
    }

    return ScreenState.detail;
  }

  @override
  RouteInformation? restoreRouteInformation(ScreenState state) {
    pushLog(state.toString(), "restoreRouteInformation");

    if (state == ScreenState.home) {
      return RouteInformation(location: '/');
    }

    if (state == ScreenState.err) {
      return RouteInformation(location: '/404');
    }

    if (state == ScreenState.settings) {
      return RouteInformation(location: '/settings');
    }

    if (state == ScreenState.detail) {
      return RouteInformation(location: '/details/${randomString()}');
    }

    return null;
  }
}
