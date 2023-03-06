import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';

class SongLyric extends StatefulWidget {
  const SongLyric({super.key, required this.api});

  final ApiController api;

  @override
  State<SongLyric> createState() => _SongLyricState();
}

class _SongLyricState extends State<SongLyric> {
  final ScrollController _controller = ScrollController();

  final double _itemHeight = 28;
  int lyricIdx = 0;

  @override
  void initState() {
    ever(widget.api.currDuration, (value) {
      if (widget.api.currLyric.isEmpty) return;

      int idx = 0;
      while (widget.api.currLyric[idx].duration.compareTo(value) < 0) {
        idx += 1;
      }
      setState(() {
        lyricIdx = max(idx - 1, 0);
      });

      _scrollToIndex(lyricIdx);
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (_controller.hasClients) {
      _controller.jumpTo(index * _itemHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool hasLyric = widget.api.currSong.value != null && widget.api.currSong.value!.lyric.value.isNotEmpty;

        return LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth * 0.5,
            height: _itemHeight * 3,
            child: hasLyric
                ? ListView.builder(
                    controller: _controller,
                    itemExtent: _itemHeight,
                    itemCount: widget.api.currSong.value?.lyric.value.length ?? 0,
                    itemBuilder: (context, index) => Text(
                          widget.api.currLyric[index].content,
                          style: TextStyle(
                              fontSize: 18,
                              color: index == lyricIdx
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).textTheme.bodyMedium!.color),
                          textAlign: TextAlign.center,
                        ))
                : Container(),
          ),
        );
      },
    );
  }
}
