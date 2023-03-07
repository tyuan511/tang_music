import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigService extends GetxService {
  late SharedPreferences pref;

  Future<ConfigService> init() async {
    pref = await SharedPreferences.getInstance();
    return this;
  }
}
