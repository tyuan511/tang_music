import 'package:get/get.dart';

class SongLyricModel {
  final Duration duration;
  final String content;

  SongLyricModel({required this.duration, required this.content});
}

class SongModel {
  final int id;
  final String name;
  final String picUrl;
  final String author;
  final Duration duration;
  var trackURL = '';
  var lyric = RxList<SongLyricModel>.empty(growable: true);

  SongModel(
      {required this.id,
      required this.name,
      required this.picUrl,
      required this.author,
      required this.duration,
      this.trackURL = ''});

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      name: json['name'],
      picUrl: json['al']["picUrl"],
      author: (json['ar'] as List).map((ee) => ee['name']).toList().join(','),
      duration: Duration(milliseconds: json['dt']),
    );
  }
}
