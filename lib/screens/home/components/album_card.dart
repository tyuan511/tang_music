import 'package:flutter/material.dart';
import 'package:tang_music/model/album_item.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    super.key,
    required this.album,
    required this.imageSize,
  });

  final double imageSize;
  final AlbumItemModel album;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          album.picUrl,
          fit: BoxFit.cover,
          width: imageSize,
          height: imageSize,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        album.name,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      )
    ]);
  }
}
