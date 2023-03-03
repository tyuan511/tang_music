import 'package:flutter/material.dart';

class PlayerController extends StatelessWidget {
  const PlayerController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSideButton(context, Icons.arrow_back_ios_rounded),
        const SizedBox(
          width: 24,
        ),
        buildPlayerButton(context),
        const SizedBox(
          width: 24,
        ),
        buildSideButton(context, Icons.arrow_forward_ios_rounded),
      ],
    );
  }

  Widget buildPlayerButton(BuildContext context) {
    return Ink(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1))
      ]),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(40),
        child: Icon(
          Icons.play_arrow_rounded,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          size: 32,
        ),
      ),
    );
  }

  Widget buildSideButton(BuildContext context, IconData icon) {
    return InkWell(
      onTap: () {},
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
