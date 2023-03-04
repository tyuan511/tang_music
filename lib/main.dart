import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/layouts/mobile_layout.dart';
import 'package:tang_music/layouts/tablet_layout.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:tang_music/theme.dart';

import 'storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(const MyApp());

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > constraints.maxHeight) {
              return TabletLayout();
            }

            return MobileLayout();
          },
        ));
  }
}
