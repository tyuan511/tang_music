import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/model/album_item.dart';
import 'package:tang_music/model/song.dart';
import 'package:tang_music/services/api_service.dart';
import 'package:tang_music/services/config_service.dart';

class ApiController extends GetxController {
  final qrcodeUrl = ''.obs;
  final userId = 0.obs;
  final currAlbum = Rx<AlbumItemModel?>(null);
  final currSongs = List<SongModel>.empty().obs;
  final currSong = Rx<SongModel?>(null);
  final player = AudioPlayer(playerId: 'tang_music_player');
  final playState = PlayerState.stopped.obs;
  final currDuration = Duration.zero.obs;
  final maxDuration = Duration.zero.obs;

  bool get logined => userId.value != 0;
  int get currSongIndex => currSong.value == null ? -1 : currSongs.indexOf(currSong.value!);
  List<SongLyricModel> get currLyric => currSong.value?.lyric ?? [];

  final _configService = Get.find<ConfigService>();
  final _apiService = Get.find<ApiService>();

  final isDarkTheme = false.obs;

  @override
  void onInit() {
    isDarkTheme.value = _configService.pref.getBool(ConfigKeys.isDarkThemeKey) ?? false;

    ever(currAlbum, (value) => getCurrAlbumSongs());
    ever(currSongs, (songs) => currSong.value = songs.first);
    ever(currSong, (song) async {
      if (song == null) return;
      if (song.trackURL == '') {
        await getSongUrl(song);
      }
      if (song.lyric.isEmpty) {
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

  getSongUrl(SongModel song) async {
    var url = await _apiService.getSongUrl(song.id);
    if (url == '') {
      Fluttertoast.showToast(msg: "获取歌曲链接失败，自动播放下一曲");
      playRelative(1);
    } else {
      song.trackURL = url;
    }
  }

  getSongLyric(SongModel song) async {
    var lyric = await _apiService.getSongLyric(song.id);
    song.lyric.value = lyric;
  }

  Future getCurrAlbumSongs() async {
    final playlist = await _apiService.getSongs(currAlbum.value?.id ?? 0);
    currSongs.value = playlist;
  }

  getUserInfo() async {
    int id = await _apiService.getUserInfo();

    if (id < 0) {
      getQrcode();
    } else {
      userId.value = id;
    }
  }

  getQrcode() async {
    var res = await _apiService.getQrcode();
    qrcodeUrl.value = res['url'];
    String key = res['unikey'];
    _checkScan(key);
  }

  _checkScan(String key) async {
    Timer(const Duration(seconds: 5), () async {
      var res = await _apiService.checkScan(key);
      switch (res['code']) {
        case 800:
          getQrcode();
          return;
        case 801:
          return _checkScan(key);
        case 802:
          return _checkScan(key);
        case 803:
          _configService.pref.setString(ConfigKeys.cookieKey, res['cookie']);
          getUserInfo();
          return;
      }
    });
  }
}
