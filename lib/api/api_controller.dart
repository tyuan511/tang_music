import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/model/album_item.dart';
import 'package:tang_music/model/song.dart';
import 'package:tang_music/storage.dart';
import 'package:tang_music/utils.dart';
import 'http_client.dart';

class ApiController extends GetxController {
  String currAuthKey = '';
  var qrcodeUrl = ''.obs;
  var userId = 0.obs;
  var currAlbum = Rx<AlbumItemModel?>(null);
  var currSongs = List<SongModel>.empty().obs;
  var currSong = Rx<SongModel?>(null);
  final player = AudioPlayer(playerId: 'tang_music_player');
  var playState = PlayerState.stopped.obs;
  var currDuration = Duration.zero.obs;
  var maxDuration = Duration.zero.obs;

  bool get logined => userId.value != 0;

  int get currSongIndex => currSong.value == null ? -1 : currSongs.indexOf(currSong.value!);

  List<SongLyricModel> get currLyric => currSong.value?.lyric.value ?? [];

  @override
  void onInit() {
    ever(currAlbum, (value) => getCurrAlbumSongs());
    ever(currSongs, (_) => currSong.value = currSongs.first);
    ever(currSong, (song) async {
      if (song == null) return;
      if (song.trackURL == '') {
        await getSongUrl(song);
      }
      if (song.lyric.value.isEmpty) {
        await getSongLyric(song);
      }

      if (song.trackURL != '') {
        await player.stop();
        await player.seek(Duration.zero);
        await player.play(UrlSource(song.trackURL));
      }
    });

    player.onDurationChanged.listen((Duration d) => maxDuration.value = d);
    player.onPositionChanged.listen((Duration p) => currDuration.value = p);
    player.onPlayerStateChanged.listen((PlayerState s) => playState.value = s);
    player.onPlayerComplete.listen((event) => playRelative(1));

    super.onInit();
  }

  @override
  void onClose() {
    player.release();
    super.onClose();
  }

  setCurrAlbum(AlbumItemModel album) {
    currAlbum.value = album;
  }

  setCurrSong(SongModel song) {
    currSong.value = song;
  }

  playRelative(int dis) {
    if (currSongIndex > -1) {
      currSong.value = currSongs[min(max(currSongIndex + dis, 0), currSongs.length - 1)];
    }
  }

  togglePlay() {
    if (playState.value == PlayerState.playing) {
      player.pause();
    }
    if (playState.value == PlayerState.paused) {
      player.resume();
    }
  }

  Future getSongUrl(SongModel song) async {
    var res = await httpClient.get("/song/url/v1?id=${song.id}&level=standard");
    var url = res.data['data'][0]['url'];
    if (url == null) {
      Fluttertoast.showToast(msg: "获取歌曲链接失败，自动播放下一曲");
      playRelative(1);
    } else {
      song.trackURL = res.data['data'][0]['url'];
    }
  }

  Future getSongLyric(SongModel song) async {
    var res = await httpClient.get("/lyric?id=${song.id}");
    String lyricString = res.data['lrc']['lyric'];
    List<String> lyricLines = lyricString.split("\n");
    for (var i = 0; i < lyricLines.length; i++) {
      String lyricLine = lyricLines[i];
      RegExp lyricRegExp = RegExp(r'^\[(.*)\](.*)$');
      var match = lyricRegExp.firstMatch(lyricLine);
      var lyric = match?.group(2)?.trim() ?? '';
      if (lyric.isNotEmpty) {
        song.lyric.value.add(SongLyricModel(
            duration: parseDurationStr(match?.group(1)?.trim() ?? ''), content: match?.group(2)?.trim() ?? ''));
      }
    }
  }

  Future<List<AlbumItemModel>> getRecommandList({bool isLogin = false}) async {
    var res = await httpClient.get("/recommend/resource");

    List result = res.data["recommend"];
    return result.map((e) => AlbumItemModel(id: e['id'], name: e['name'], picUrl: e['picUrl'])).toList();
  }

  Future<List<AlbumItemModel>> getUserAlbumList() async {
    if (userId.value == 0) {
      return [];
    }
    var res = await httpClient.get("/user/playlist?uid=${userId.value}");
    List result = res.data["playlist"];
    return result.map((e) => AlbumItemModel(id: e['id'], name: e['name'], picUrl: e['coverImgUrl'])).toList();
  }

  Future getCurrAlbumSongs() async {
    if (currAlbum.value == null) {
      return [];
    }

    var res = await httpClient.get("/playlist/track/all?id=${currAlbum.value!.id}");

    currSongs.value = (res.data['songs'] as List).map((e) => SongModel.fromJson(e)).toList();
  }

  getUserInfo() async {
    var res = await httpClient.get('/user/account?timerstamp=${DateTime.now()}');
    if (res.data['account']['status'] != 0) {
      getQrcode();
      return;
    }
    userId.value = res.data['account']['id'];
  }

  getQrcode() async {
    var res = await httpClient.get("/login/qr/key?timerstamp=${DateTime.now()}");
    currAuthKey = res.data["data"]["unikey"];

    var res2 = await httpClient.get("/login/qr/create?key=$currAuthKey&timerstamp=${DateTime.now()}");
    qrcodeUrl.value = res2.data['data']['qrurl'];
    _checkScan();
  }

  _checkScan() async {
    Timer(const Duration(seconds: 5), () async {
      var res3 = await httpClient.get("/login/qr/check?key=$currAuthKey&timerstamp=${DateTime.now()}");
      switch (res3.data['code']) {
        case 800:
          getQrcode();
          return;
        case 801:
          return _checkScan();
        case 802:
          return _checkScan();
        case 803:
          Storage.local.setString(ConfigKeys.cookieKey, res3.data['cookie']);
          getUserInfo();
          return;
      }
    });
  }
}
