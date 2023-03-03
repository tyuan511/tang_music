import 'package:flutter/material.dart';
import 'package:tang_music/screens/home/home_screen.dart';
import 'dart:math' as math;

import 'package:tang_music/screens/player/player_screen.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: math.min(size.width, 500),
            decoration: BoxDecoration(
                border: Border(
                    right:
                        BorderSide(width: 1, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08)))),
            child: const PlayerScreen(),
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(color: Colors.yellow),
            child: const HomeScreen(),
          ))
        ],
      ),
    );
  }
}
