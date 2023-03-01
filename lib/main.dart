import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tang_music/music_player.dart';
import "package:tang_music/playlist.dart";
import 'package:tang_music/store/player_store.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PlayerStore(),
      child: const MyApp(),
    ),
  );

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TangMusic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TangMusic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 480,
          child: Player(),
        ),
        Expanded(child: Playlist())
      ],
    );
  }
}
