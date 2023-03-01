import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tang_music/components/my_playlist.dart';
import 'package:tang_music/components/recommand_playlist.dart';
import 'package:tang_music/components/settings.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 64,
              ),
              child: const TabBar(
                // padding: EdgeInsets.only(top: 32, bottom: 16),
                labelColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                unselectedLabelColor: Colors.black54,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: '我的'),
                  Tab(text: '推荐'),
                  Tab(text: '设置'),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: const TabBarView(
              children: [MyPlaylist(), RecommandPlaylist(), Settings()]),
          backgroundColor: Colors.white,
        ));
  }
}
