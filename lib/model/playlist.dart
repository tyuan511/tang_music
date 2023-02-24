import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tang_music/consts.dart' as consts;
import 'package:audioplayers/audioplayers.dart';
import 'package:tang_music/model/song.dart';

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

  Future<List<SongModel>> getListSongs(int id) async {
    print(id);
    final response = await http.get(Uri.parse('${consts.apiBaseUrl}/playlist/track/all?id=$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final ids = data['songs'].map((e) => e['id']).toList().join(',');
      final res = await http.get(Uri.parse('${consts.apiBaseUrl}/song/url/v1?id=$ids&level=standard'));
      var data2 = jsonDecode(res.body);
      print(data2);
      List<SongModel> songs = [];

      (data['songs'] as List).asMap().entries.forEach((entry) {
        var item =
            (data2['data'] as List).firstWhere((element) => element['id'] == entry.value['id'], orElse: () => null);
        if (item != null) {
          entry.value['trackURL'] = item['url'];
          songs.insert(entry.key, SongModel.fromJson(entry.value));
        }
      });

      return songs;
    } else {
      return [];
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
