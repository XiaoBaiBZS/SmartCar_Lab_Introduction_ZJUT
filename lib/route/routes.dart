import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_lab/page/about/privacy_policy_page.dart';
import 'package:smart_car_lab/page/about/user_agreement_page.dart';
import 'package:smart_car_lab/page/home/home_page.dart';
import 'package:smart_car_lab/page/slide/slide_content/base_slide_content.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return pageRoute(const HomePage(), settings: settings);
      case RoutePath.baseSlideContent:
        return pageRoute(const BaseSlideContent(), settings: settings);
      case RoutePath.privacy_policy_page:
        return pageRoute(const PrivacyPolicyPage(), settings: settings);
      case RoutePath.user_agreement_page:
        return pageRoute(const UserAgreementPage(), settings: settings);
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
  static const String baseSlideContent = "/slide/slide_content";
  static const String privacy_policy_page = "/about/privacy_policy_page";
  static const String user_agreement_page = "/about/user_agreement_page";

}
