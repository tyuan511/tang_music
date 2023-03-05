import 'package:flutter/material.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/screens/home/home_screen.dart';

import 'package:tang_music/screens/player/player_screen.dart';
import 'package:tang_music/screens/playlist/playlist_screen.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sideWidth = size.width * 0.4;

    return Scaffold(
      key: GlobalKeys.tabletLayoutScaffoldKey,
      drawer: Drawer(width: sideWidth, child: const PlaylistScreen()),
      body: Row(
        children: [
          Container(
            width: sideWidth,
            decoration: BoxDecoration(
                border: Border(
                    right:
                        BorderSide(width: 1, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08)))),
            child: PlayerScreen(),
          ),
          const Expanded(child: HomeScreen())
        ],
      ),
    );
  }
}
