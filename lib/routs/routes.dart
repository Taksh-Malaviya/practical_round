import 'package:flutter/cupertino.dart';
import 'package:practical/screen/view/home.dart';

class Routes {
  static String homeScreen = "/";

  static Map<String, WidgetBuilder> myRoutes = {
    homeScreen: (context) => Home(),
  };
}
