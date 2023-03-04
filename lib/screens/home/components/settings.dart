import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/storage.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final baseUrlController = TextEditingController();

  _SettingsState() {
    _initSetting();
  }

  _initSetting() async {
    String? configBaseUrl = Storage.local.getString(ConfigKeys.apiBaseUrlKey);
    baseUrlController.text = configBaseUrl ?? '';
  }

  @override
  void dispose() {
    baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "服务器地址",
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
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
                    decoration: const InputDecoration(hintText: "请输入服务器地址", border: InputBorder.none),
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
                    Storage.local.setString(ConfigKeys.apiBaseUrlKey, baseUrlController.text);
                    Get.snackbar("保存成功", '当前设置立即生效');
                  },
                  child: const Text('确定'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
