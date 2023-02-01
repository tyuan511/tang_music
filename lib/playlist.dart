import 'package:flutter/material.dart';
import 'package:tang_music/components/playlist_item.dart';
import 'package:tang_music/music_player.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  PlaylistState createState() => PlaylistState();
}

class PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    var crossAxisCount = 3;
    double spacing = 32;
    var colWidth = (MediaQuery.of(context).size.width - 400 - spacing * (crossAxisCount + 1)) / crossAxisCount;
    var mainAxisExtent = colWidth + 60;

    return Column(
      children: [
        const DefaultTabController(
          length: 2,
          child: SizedBox(
            width: 240,
            child: TabBar(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              unselectedLabelColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  child: Text(
                    "我的",
                  ),
                ),
                Tab(
                  child: Text(
                    "推荐",
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GridView(
              padding: EdgeInsets.only(left: spacing, right: spacing, top: 8, bottom: spacing),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: mainAxisExtent,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing),
              children: const [
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem(),
                PlaylistItem()
              ]),
        )
      ],
    );
  }
}
