import 'package:flutter/material.dart';
import 'package:tang_music/components/my_playlist.dart';
import 'package:tang_music/components/recommand_playlist.dart';
import 'package:tang_music/components/settings.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              width: 300,
              child: TabBar(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                labelColor: Colors.black,
                labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                unselectedLabelColor: Colors.black54,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                controller: _controller,
                tabs: const [
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
                  Tab(
                    child: Text(
                      "设置",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 81,
              child: TabBarView(
                controller: _controller,
                children: const [MyPlaylist(), RecommandPlaylist(), Settings()],
              ),
            )
          ],
        ),
      ],
    );
  }
}
