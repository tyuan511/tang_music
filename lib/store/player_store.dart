import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tang_music/model/song.dart';

class PlayerStore extends ChangeNotifier {
  List<SongModel> songs = [];
  final player = AudioPlayer();
  int _index = 0;
  Duration position = const Duration(seconds: 0);
  Duration max = const Duration(seconds: 0);
  PlayerState state = PlayerState.stopped;

  PlayerStore() {
    player.onPositionChanged.listen((Duration p) {
      position = p;
      notifyListeners();
    });

    player.onDurationChanged.listen((Duration d) {
      max = d;
      notifyListeners();
    });

    player.onPlayerStateChanged.listen((PlayerState s) {
      state = s;

      if (s == PlayerState.completed) {
        playNext();
      }
    });
  }

  int get index {
    return _index;
  }

  set index(int idx) {
    _index = idx;
    if (idx <= songs.length - 1 && songs[index].trackURL != null) {
      player.stop();
      player.play(UrlSource(songs[index].trackURL!));
    }
  }

  double get progress {
    if (max.inSeconds != 0) {
      return (position.inSeconds / max.inSeconds).toDouble();
    }

    return 0.0;
  }

  SongModel get currSong {
    return index >= songs.length
        ? SongModel(
            id: 0,
            name: '暂无歌曲',
            picUrl: "https://p2.music.126.net/pa1t9G_Mt2xJm_xqUUjvIw==/109951163676905233.jpg",
            author: "YUANTANG",
            trackURL: "")
        : songs[index];
  }

  toggleState() async {
    if (state == PlayerState.playing) {
      await player.pause();
    } else if (state == PlayerState.paused) {
      await player.resume();
    }
  }

  renew(List<SongModel> list) {
    songs = list;
    playIndex(0);
    notifyListeners();
  }

  Future playIndex(int idx) async {
    index = idx;
  }

  playPrev() {
    if (index > 0) {
      index--;
      notifyListeners();
    }
  }

  playNext() {
    if (index < songs.length - 1) {
      index++;
      notifyListeners();
    }
  }
}
