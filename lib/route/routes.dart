import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_lab/page/home/home_page.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return pageRoute(const HomePage(), settings: settings);
    }
    return pageRoute(Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("404:Route Path ${settings.name} Not Found"),
      )),
    ));
  }

  static MaterialPageRoute pageRoute(Widget page,
      {RouteSettings? settings,
      bool? fullscreenDialog,
      bool? maintainState,
      bool? allowSnapshotting}) {
    return MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

class RoutePath {
  //HomePage
  static const String home = "/";

}
