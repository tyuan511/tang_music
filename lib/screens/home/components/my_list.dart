import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tang_music/screens/home/components/album_card.dart';

class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double homeScreenWidth = size.width < size.height ? size.width : size.width - min(size.width, 500);
    double imageSize = (homeScreenWidth - 80) / 3;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "我的歌单",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          Expanded(
              child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              mainAxisExtent: imageSize + 32,
            ),
            itemCount: 2,
            itemBuilder: (context, index) => AlbumCard(imageSize: imageSize),
          ))
        ],
      ),
    );
  }
}
