String formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;

  final minutesString = '$minutes'.padLeft(2, '0');
  final secondsString = '$seconds'.padLeft(2, '0');
  return '$minutesString:$secondsString';
}

Duration parseDurationStr(String str) {
  RegExp duration = RegExp(r'^(\d*):(\d*)\.(\d*)$');
  var match = duration.firstMatch(str);

  int minutes = int.parse(match?.group(1) ?? '0');
  int seconds = int.parse(match?.group(2) ?? '0');
  int milliseconds = int.parse(match?.group(3) ?? '0');

  return Duration(minutes: minutes, seconds: seconds, milliseconds: milliseconds);
}
