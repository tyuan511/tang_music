import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/model/album_item.dart';
import 'dart:math' as math;

import 'package:tang_music/screens/home/components/album_card.dart';

class RecommandList extends StatefulWidget {
  const RecommandList({Key? key}) : super(key: key);

  @override
  State<RecommandList> createState() => _RecommandListState();
}

class _RecommandListState extends State<RecommandList> with AutomaticKeepAliveClientMixin {
  ApiController api = Get.put(ApiController());

  List<AlbumItemModel> recommandList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    List<AlbumItemModel> data = await api.getRecommandList();
    setState(() {
      recommandList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Size size = MediaQuery.of(context).size;
    double homeScreenWidth = size.width < size.height ? size.width : size.width - math.min(size.width, 500);
    double imageSize = (homeScreenWidth - 80) / 3;

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        mainAxisExtent: imageSize + 56,
      ),
      itemCount: recommandList.length,
      itemBuilder: (context, index) => AlbumCard(album: recommandList[index], imageSize: imageSize),
    );
  }
}
