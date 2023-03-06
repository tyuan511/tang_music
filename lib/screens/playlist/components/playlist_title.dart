import 'package:flutter/material.dart';
import 'package:tang_music/api/api_controller.dart';

class PlaylistTitle extends StatelessWidget {
  const PlaylistTitle({Key? key, required this.api}) : super(key: key);

  final ApiController api;

  @override
  Widget build(BuildContext context) {
    double titleHeight = 200;

    if (api.currAlbum.value == null) {
      return Container();
    }

    return OrientationBuilder(
      builder: (context, orientation) => Stack(
        children: [
          Container(
              width: double.infinity,
              height: titleHeight,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(api.currAlbum.value!.picUrl), fit: BoxFit.cover))),
          Container(
            width: double.infinity,
            height: titleHeight,
            color: Colors.black.withOpacity(0.6),
          ),
          SizedBox(
            height: titleHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Text(
                  api.currAlbum.value!.name,
                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          if (orientation == Orientation.portrait)
            const SafeArea(
                child: BackButton(
              color: Colors.white,
            )),
        ],
      ),
    );
  }
}
