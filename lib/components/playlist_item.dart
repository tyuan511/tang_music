import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tang_music/model/playlist.dart';
import 'package:tang_music/store/player_store.dart';

class PlaylistItem extends StatelessWidget {
  final PlaylistItemModel model;

  const PlaylistItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerStore>(
      builder: (context, playerStore, child) {
        return GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  model.picUrl,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              )
            ],
          ),
          onTap: () async {
            var songs = await PlaylistModel().getListSongs(model.id);
            playerStore.renew(songs);
          },
        );
      },
    );
  }
}
