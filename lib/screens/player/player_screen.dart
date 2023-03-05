import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/screens/player/components/song_info.dart';

import 'components/player_controller.dart';

class PlayerScreen extends StatelessWidget {
  PlayerScreen({Key? key}) : super(key: key);

  final ApiController api = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
      () => SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              SongInfo(song: api.currSong.value),
              const Spacer(
                flex: 3,
              ),
              PlayerController(api: api),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
