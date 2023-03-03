import 'package:flutter/material.dart';
import 'package:tang_music/screens/home/home_screen.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
