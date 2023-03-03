import 'package:flutter/material.dart';
import 'package:tang_music/screens/player/components/song_info.dart';

import 'components/player_controller.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          SongInfo(),
          Spacer(
            flex: 3,
          ),
          PlayerController(),
          Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
