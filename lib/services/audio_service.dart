import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';

class MyAudioService extends BaseAudioHandler with GetxServiceMixin {
  final api = Get.put(ApiController());

  static init() async {
    return await AudioService.init(
      builder: () => MyAudioService(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.music.tang',
        androidNotificationChannelName: 'Tang Music',
      ),
    );
  }

  @override
  Future<void> skipToNext() async {
    api.playRelative(1);
  }

  @override
  Future<void> skipToPrevious() async {
    api.playRelative(-1);
  }
}
