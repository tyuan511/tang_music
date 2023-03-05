import 'package:flutter/material.dart';

const apiBaseUrl = "http://124.223.92.233:3000";

class ConfigKeys {
  static String get apiBaseUrlKey => "API_BASE_URL_KEY";
  static String get cookieKey => "API_COOKIE_KEY";
}

class GlobalKeys {
  static final GlobalKey<ScaffoldState> tabletLayoutScaffoldKey = GlobalKey();
}
