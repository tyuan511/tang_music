import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tang_music/model/song.dart';

class PlayerStore extends ChangeNotifier {
  List<SongModel> songs = [];
  int index = 0;
  final player = AudioPlayer();

  SongModel get currSong {
    return songs[index];
  }

  renew(List<SongModel> list) {
    songs = list;
    notifyListeners();
  }

  Future playCurrent() async {}

  playPrev() {
    if (index > 0) {
      index--;
      notifyListeners();
    }
  }

  playNext() {
    if (index < songs.length) {
      index++;
      notifyListeners();
    }
  }
}
