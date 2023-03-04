import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static late SharedPreferences local;

  static init() async {
    local = await SharedPreferences.getInstance();
  }
}
