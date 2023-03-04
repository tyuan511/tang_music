import 'package:flutter/material.dart';
import 'package:tang_music/screens/home/home_screen.dart';

import 'package:tang_music/screens/player/player_screen.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: size.width * 0.4,
            decoration: BoxDecoration(
                border: Border(
                    right:
                        BorderSide(width: 1, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08)))),
            child: const PlayerScreen(),
          ),
          const Expanded(child: HomeScreen())
        ],
      ),
    );
  }
}
