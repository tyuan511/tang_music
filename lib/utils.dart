String formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;

  final minutesString = '$minutes'.padLeft(2, '0');
  final secondsString = '$seconds'.padLeft(2, '0');
  return '$minutesString:$secondsString';
}
