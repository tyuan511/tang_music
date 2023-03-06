import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/consts.dart';

import 'components/play_item.dart';
import 'components/playlist_title.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final ApiController api = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (api.currAlbum.value == null) {
          return const Center(
            child: Text(
              '暂无正在播放的歌单',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return Column(
          children: [
            PlaylistTitle(api: api),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: api.currSongs.length,
                    itemBuilder: (context, index) => PlayItem(
                        song: api.currSongs[index],
                        index: index,
                        isActive: api.currSong.value == api.currSongs[index],
                        onTap: () {
                          api.setCurrSong(api.currSongs[index]);
                          GlobalKeys.tabletLayoutScaffoldKey.currentState?.closeDrawer();
                        })))
          ],
        );
      }),
    );
  }
}
