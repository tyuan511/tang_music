class SongModel {
  final int id;
  final String name;
  final String picUrl;
  final String author;
  final Duration duration;
  String? trackURL = '';

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
