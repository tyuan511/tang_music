import 'package:flutter/material.dart';
import 'package:tang_music/model/song.dart';

class SongInfo extends StatelessWidget {
  const SongInfo({Key? key, this.song}) : super(key: key);

  final SongModel? song;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              song == null ? "https://p2.music.126.net/dMLavkxcrHur9xag1lwYtA==/109951168377889031.jpg" : song!.picUrl,
              width: p1.maxWidth * 0.4,
              height: p1.maxWidth * 0.4,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            song == null ? "暂无歌曲" : song!.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            song == null ? "Made by Tangge" : song!.author,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
