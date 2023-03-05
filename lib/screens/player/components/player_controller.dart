import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/consts.dart';

class PlayerController extends StatelessWidget {
  const PlayerController({super.key, required this.api});

  final ApiController api;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          IconButton(
              onPressed: () {
                GlobalKeys.tabletLayoutScaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu_rounded)),
          const Spacer(),
          buildSideButton(context, Icons.arrow_back_ios_rounded, -1),
          const SizedBox(
            width: 24,
          ),
          buildPlayerButton(context),
          const SizedBox(
            width: 24,
          ),
          buildSideButton(context, Icons.arrow_forward_ios_rounded, 1),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.loop_rounded)),
          const Spacer(),
        ],
      ),
    );
  }

  Widget buildPlayerButton(BuildContext context) {
    return Ink(
      width: 72,
      height: 72,
      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1))
      ]),
      child: InkWell(
        onTap: () {
          api.togglePlay();
        },
        borderRadius: BorderRadius.circular(36),
        child: Icon(
          api.playState.value == PlayerState.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          size: 32,
        ),
      ),
    );
  }

  Widget buildSideButton(BuildContext context, IconData icon, int dis) {
    return InkWell(
      onTap: () {
        api.playRelative(dis);
      },
      borderRadius: BorderRadius.circular(32),
      child: SizedBox(
        width: 64,
        height: 64,
        child: Icon(
          icon,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}
