import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    super.key,
    required this.imageSize,
  });

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          "https://p1.music.126.net/ATce5mCIf_GqCLBqJcmzTg==/109951165166142900.jpg",
          fit: BoxFit.cover,
          width: imageSize,
          height: imageSize,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        "二十岁后的人生像是按了加快键",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    ]);
  }
}
