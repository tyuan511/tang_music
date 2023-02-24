import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tang_music/store/player_store.dart';
import 'package:tang_music/utils.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerStore>(
        builder: (context, player, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 160)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        player.currSong.picUrl,
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Text(
                        player.currSong.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      child: Text(
                        player.currSong.author,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: Row(
                        children: [
                          Text(
                            formatDuration(player.position),
                            style: const TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: LinearProgressIndicator(
                                  value: player.progress,
                                )),
                          ),
                          Text(
                            formatDuration(player.max),
                            style: const TextStyle(color: Colors.black87, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 36, bottom: 80),
                      child: SizedBox(
                        width: 240,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                              onPressed: () {
                                player.playPrev();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(34)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 4,
                                        blurRadius: 8,
                                      )
                                    ]),
                                child: player.state == PlayerState.playing
                                    ? const Icon(
                                        Icons.pause,
                                        size: 32,
                                      )
                                    : const Icon(
                                        Icons.play_arrow,
                                        size: 32,
                                      ),
                              ),
                              onTap: () {
                                player.toggleState();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                              onPressed: () {
                                player.playNext();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
  }
}
