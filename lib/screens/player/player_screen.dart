import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/screens/player/components/song_info.dart';

import 'components/player_controller.dart';
import 'components/song_lyric.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final ApiController api = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
      () => RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (value) {
          Fluttertoast.showToast(msg: value.toString());
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                SongInfo(song: api.currSong.value),
                const Spacer(),
                SongLyric(api: api),
                const Spacer(),
                PlayerController(api: api),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
