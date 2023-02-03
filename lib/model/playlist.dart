import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tang_music/consts.dart' as consts;
import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer();

class PlaylistModel {
  Future<List<PlaylistItemModel>> getRecommandList() async {
    final response = await http.get(Uri.parse('${consts.apiBaseUrl}/personalized'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return (data['result'] as List<dynamic>).map((item) => PlaylistItemModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> getListSongs(int id) async {
    final response = await http.get(Uri.parse('${consts.apiBaseUrl}/playlist/detail?id=$id'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var trackIds = (data['playlist']['trackIds'] as List).map<int>((item) => item['id']).toList();

      if (trackIds.isNotEmpty) {
        final res2 = await http.get(Uri.parse('${consts.apiBaseUrl}/song/url/v1?id=${trackIds[0]}&level=standard'));

        if (res2.statusCode == 200) {
          var data2 = jsonDecode(res2.body);
          String url = data2['data'][0]['url'];
          print(url);
          // await player.stop();
          await player.play(UrlSource(url));
        }
      }
    }
  }
}

class PlaylistItemModel {
  final int id;
  final String name;
  final String picUrl;

  const PlaylistItemModel({required this.id, required this.name, required this.picUrl});

  factory PlaylistItemModel.fromJson(Map<String, dynamic> json) {
    return PlaylistItemModel(
      id: json['id'],
      name: json['name'],
      picUrl: json["picUrl"],
    );
  }
}
