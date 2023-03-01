import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tang_music/music_player.dart';
import "package:tang_music/playlist.dart";
import 'package:tang_music/store/player_store.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PlayerStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    return Row(
      children: const [
        SizedBox(
          width: 400,
          child: Player(),
        ),
        Expanded(child: Playlist())
      ],
    );
  }
}
