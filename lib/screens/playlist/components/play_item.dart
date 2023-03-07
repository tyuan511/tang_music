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
        color: index % 2 == 0
            ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1)
            : Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration:
              BoxDecoration(border: Border(left: BorderSide(width: 4, color: isActive ? color : Colors.transparent))),
          child: Row(
            children: [
              Text('${index + 1}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: color,
                      )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  song.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: color,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
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
