import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/layouts/mobile_layout.dart';
import 'package:tang_music/layouts/tablet_layout.dart';
import 'package:flutter/services.dart';
import 'package:tang_music/services/api_service.dart';
import 'package:tang_music/services/audio_service.dart';
import 'dart:io';

import 'package:tang_music/theme.dart';
import 'services/config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ApiService());
  await Get.putAsync(() => ConfigService().init());
  await MyAudioService.init();

  runApp(MyApp());

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          themeMode: _apiController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
          home: OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.landscape ? const TabletLayout() : const MobileLayout(),
          )),
    );
  }
}
