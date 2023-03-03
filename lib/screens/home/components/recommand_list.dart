import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tang_music/screens/home/components/album_card.dart';

class RecommandList extends StatelessWidget {
  const RecommandList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double homeScreenWidth = size.width < size.height ? size.width : size.width - math.min(size.width, 500);
    double imageSize = (homeScreenWidth - 80) / 3;

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        mainAxisExtent: imageSize + 32,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => AlbumCard(imageSize: imageSize),
    );
  }
}
