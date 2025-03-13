import 'package:flutter/cupertino.dart';
import 'package:practical/screen/view/deatil.dart';
import 'package:practical/screen/view/home.dart';

class Routes {
  static String homeScreen = "/";
  static String detail = "/detail";

  static Map<String, WidgetBuilder> myRoutes = {
    homeScreen: (context) => Home(),
    detail: (context) => Detail(),
  };
}
