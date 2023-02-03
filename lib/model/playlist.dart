import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tang_music/consts.dart' as consts;
import 'dart:developer';

class PlaylistModel {
  Future<List<PlaylistItemModel>> getRecommandList() async {
    final response = await http.get(Uri.parse('${consts.apiBaseUrl}/personalized'));

    if (response.statusCode == 200) {
      log(response.body);

      var data = jsonDecode(response.body);

      return (data['result'] as List<dynamic>).map((item) => PlaylistItemModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load album');
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
