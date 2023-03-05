import 'package:flutter/material.dart';
import 'package:tang_music/model/song.dart';
import 'package:tang_music/utils.dart';

class PlayItem extends StatelessWidget {
  const PlayItem({super.key, required this.song, required this.index, required this.onTap, this.isActive = false});

  final SongModel song;
  final int index;
  final bool isActive;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color color = isActive ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        color: index % 2 == 0 ? Colors.white : Colors.white10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration:
              BoxDecoration(border: Border(left: BorderSide(width: 4, color: isActive ? color : Colors.transparent))),
          child: Row(
            children: [
              Text('${index + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                  )),
              const SizedBox(
                width: 16,
              ),
              Text(
                song.name,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                song.author,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),
              ),
              const Spacer(),
              Text(
                formatDuration(song.duration),
              )
            ],
          ),
        ),
      ),
    );
  }
}
