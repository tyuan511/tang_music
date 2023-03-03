import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tang_music/layouts/mobile_layout.dart';
import 'package:tang_music/layouts/tablet_layout.dart';
import 'package:tang_music/store/player_store.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:tang_music/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PlayerStore(),
      child: const MyApp(),
    ),
  );

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      home: isMobile
          ? MobileLayout(
              child: Container(),
            )
          : TabletLayout(
              child: Container(),
            ),
    );
  }
}
