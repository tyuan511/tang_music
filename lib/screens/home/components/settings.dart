import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/storage.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with AutomaticKeepAliveClientMixin {
  final baseUrlController = TextEditingController();

  _SettingsState() {
    _initSetting();
  }

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);

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
                    Fluttertoast.showToast(
                      msg: "保存成功，立即生效",
                    );
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
