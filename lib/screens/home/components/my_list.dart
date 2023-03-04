import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/model/album_item.dart';
import 'package:tang_music/screens/home/components/album_card.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final ApiController api = Get.put(ApiController());

  List<AlbumItemModel> myList = [];

  @override
  initState() {
    getData();

    super.initState();
  }

  getData() async {
    List<AlbumItemModel> data = await api.getUserAlbumList();
    setState(() {
      myList = data;
    });
  }

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
                fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    mainAxisExtent: imageSize + 56,
                  ),
                  itemCount: myList.length,
                  itemBuilder: (context, index) => AlbumCard(
                      album:
                          AlbumItemModel(id: myList[index].id, name: myList[index].name, picUrl: myList[index].picUrl),
                      imageSize: imageSize)))
        ],
      ),
    );
  }
}
