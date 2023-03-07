import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/model/album_item.dart';

class AlbumCard extends StatelessWidget {
  AlbumCard({
    super.key,
    required this.album,
    required this.imageSize,
  });

  final double imageSize;
  final AlbumItemModel album;

  final ApiController api = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        api.setCurrAlbum(album);
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ]),
    );
  }
}
