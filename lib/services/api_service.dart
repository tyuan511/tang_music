import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/http_client.dart';
import 'package:tang_music/model/album_item.dart';
import 'package:tang_music/model/song.dart';
import 'package:tang_music/utils.dart';

class ApiService extends GetxService {
  Future<List<AlbumItemModel>> getRecommandList(int userId) async {
    if (userId == 0) {
      return [];
    }

    var res = await httpClient.get("/recommend/resource");
    List result = res.data["recommend"];
    return result.map((e) => AlbumItemModel(id: e['id'], name: e['name'], picUrl: e['picUrl'])).toList();
  }

  Future<List<AlbumItemModel>> getUserAlbumList(int userId) async {
    if (userId == 0) {
      return [];
    }
    var res = await httpClient.get("/user/playlist?uid=$userId");
    List result = res.data["playlist"];
    return result.map((e) => AlbumItemModel(id: e['id'], name: e['name'], picUrl: e['coverImgUrl'])).toList();
  }

  Future<int> getUserInfo() async {
    var res = await httpClient.get('/user/account?timerstamp=${DateTime.now()}');
    if (res.data['account']['status'] != 0) {
      return -1;
    }
    return res.data['account']['id'];
  }

  Future<Map<String, dynamic>> getQrcode() async {
    var res = await httpClient.get("/login/qr/key?timerstamp=${DateTime.now()}");
    String unikey = res.data["data"]["unikey"];
    var res2 = await httpClient.get("/login/qr/create?key=$unikey&timerstamp=${DateTime.now()}");

    return {"unikey": unikey, "url": res2.data['data']['qrurl'] ?? ''};
  }

  Future<Map<String, dynamic>> checkScan(key) async {
    var res = await httpClient.get("/login/qr/check?key=$key&timerstamp=${DateTime.now()}");
    return {"code": res.data['code'], "cookie": res.data["cookie"] ?? ''};
  }

  Future<List<SongModel>> getSongs(int listId) async {
    if (listId == 0) {
      return [];
    }

    var res = await httpClient.get("/playlist/track/all?id=$listId");

    return (res.data['songs'] as List).map((e) => SongModel.fromJson(e)).toList();
  }

  Future<List<SongLyricModel>> getSongLyric(int id) async {
    if (id == 0) {
      return [];
    }

    var res = await httpClient.get("/lyric?id=$id");

    String lyricString = res.data['lrc']['lyric'];
    List<String> lyricLines = lyricString.split("\n");
    List<SongLyricModel> lyric = List.empty(growable: true);

    for (var i = 0; i < lyricLines.length; i++) {
      String lyricLine = lyricLines[i];
      RegExp lyricRegExp = RegExp(r'^\[(.*)\](.*)$');

      var match = lyricRegExp.firstMatch(lyricLine);
      String lyricDuration = match?.group(1)?.trim() ?? '';
      String lyricContent = match?.group(2)?.trim() ?? '';

      if (lyricContent.isNotEmpty) {
        lyric.add(SongLyricModel(duration: parseDurationStr(lyricDuration), content: lyricContent));
      }
    }

    return lyric;
  }

  Future<String> getSongUrl(int id) async {
    var res = await httpClient.get("/song/url/v1?id=$id&level=standard");
    var url = res.data['data'][0]['url'];
    if (url == null) {
      Fluttertoast.showToast(msg: "获取歌曲链接失败，自动播放下一曲");
      return '';
    } else {
      return res.data['data'][0]['url'];
    }
  }
}
