import 'package:flutter/material.dart';
import 'package:tang_music/components/playlist_item.dart';
import 'package:tang_music/model/playlist.dart';

class RecommandPlaylist extends StatefulWidget {
  const RecommandPlaylist({Key? key}) : super(key: key);

  @override
  State<RecommandPlaylist> createState() => _RecommandPlaylistState();
}

class _RecommandPlaylistState extends State<RecommandPlaylist> with AutomaticKeepAliveClientMixin {
  late Future<List<PlaylistItemModel>> _futureRecommandList;
  final _playlistModel = PlaylistModel();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _futureRecommandList = _playlistModel.getRecommandList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var crossAxisCount = 3;
    double spacing = 32;
    var colWidth = (MediaQuery.of(context).size.width - 400 - spacing * (crossAxisCount + 1)) / crossAxisCount;
    var mainAxisExtent = colWidth + 64;

    return FutureBuilder<List<PlaylistItemModel>>(
      future: _futureRecommandList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.only(left: spacing, right: spacing, top: 8, bottom: spacing),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: mainAxisExtent,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing),
            itemBuilder: (context, index) {
              return PlaylistItem(
                model: snapshot.data![index],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
