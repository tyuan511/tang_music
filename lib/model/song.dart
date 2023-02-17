class SongModel {
  final int id;
  final String name;
  final String picUrl;
  final String author;
  final String? trackURL;

  SongModel({required this.id, required this.name, required this.picUrl, required this.author, required this.trackURL});

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        id: json['id'],
        name: json['name'],
        picUrl: json['al']["picUrl"],
        author: json['ar'][0]["name"],
        trackURL: json['trackURL']);
  }
}
