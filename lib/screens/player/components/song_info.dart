import 'package:flutter/material.dart';

class SongInfo extends StatelessWidget {
  const SongInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (po, p1) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://p2.music.126.net/dMLavkxcrHur9xag1lwYtA==/109951168377889031.jpg",
              width: p1.maxWidth * 0.48,
              height: p1.maxWidth * 0.48,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "念念不忘",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "张靓颖",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
