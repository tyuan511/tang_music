import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network("https://p1.music.126.net/X3lwU-K8ahwkswzKmm_xMA==/3435973846756513.jpg"),
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        const Text(
          "一曲戏腔极尽风流，一抹笑靥极尽欢颜。",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16, color: Colors.black),
        )
      ],
    );
  }
}
