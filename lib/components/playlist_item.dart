import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tang_music/model/playlist.dart';

class PlaylistItem extends StatelessWidget {
  final PlaylistItemModel model;

  const PlaylistItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: const TextStyle(fontSize: 16, color: Colors.black),
        )
      ],
    );
  }
}
