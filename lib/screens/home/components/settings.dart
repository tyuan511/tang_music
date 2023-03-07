import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/services/config_service.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with AutomaticKeepAliveClientMixin {
  final baseUrlController = TextEditingController();
  final _configService = Get.find<ConfigService>();
  final _apiController = Get.put(ApiController());

  _SettingsState() {
    _initSetting();
  }

  @override
  bool get wantKeepAlive => true;

  _initSetting() async {
    String? configBaseUrl = _configService.pref.getString(ConfigKeys.apiBaseUrlKey);
    baseUrlController.text = configBaseUrl ?? '';
  }

  @override
  void dispose() {
    baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "服务地址",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    controller: baseUrlController,
                    decoration: InputDecoration(
                      hintText: "请输入服务器地址",
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 60,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    _configService.pref.setString(ConfigKeys.apiBaseUrlKey, baseUrlController.text);
                    Fluttertoast.showToast(
                      msg: "保存成功，立即生效",
                    );
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  child: const Text('确定'),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                "暗黑模式",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Obx(
                () => Switch(
                  activeColor: Colors.pinkAccent,
                  value: _apiController.isDarkTheme.value,
                  onChanged: (value) {
                    _apiController.isDarkTheme.value = value;
                    _configService.pref.setBool(ConfigKeys.isDarkThemeKey, value);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
