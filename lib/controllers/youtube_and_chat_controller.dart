import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:steaming_app_poc/models/youtube_chat_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/status_loading.dart';
import '../services/youtube_service.dart';

class YoutubeAndChatController extends GetxController {
  final Rx<StatusLoading> chatLoading = Rx(StatusLoading.none);
  YoutubePlayerController? youtubeController;
  final String liveBroadcastId = 'DXQfkbjd5K4';
  YouTubeService? youtubeService;
  RxList<Item> messageList = RxList<Item>([]);
  RxBool isFullScreen = RxBool(false);
  RxBool isPlay = RxBool(false);
  Rx<bool> isTouch = Rx<bool>(true);
  Timer? timer;
  String? nextPageToken;

  @override
  void onInit() {
    super.onInit();
    initYoutube();
  }

  initYoutube() {
    chatLoading.value = StatusLoading.loading;
    youtubeController = YoutubePlayerController(
      initialVideoId: "DXQfkbjd5K4",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        forceHD: true,
        isLive: false,
        hideControls: true,
        showLiveFullscreenButton: true,
      ),
    );
    youtubeService =
        YouTubeService(apiKey: "AIzaSyABA9EDzgKSXtCuD0UIx86O7TOupRce7as");

    startPolling();
  }

  void startPolling() async {
    final liveChatId = await youtubeService!.getLiveChatId(liveBroadcastId);
    timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      final response = await youtubeService!
          .getLiveChatMessages(liveChatId, pageToken: nextPageToken);
      messageList.addAll(response.items);
      nextPageToken = response.nextPageToken;
      chatLoading.value = StatusLoading.succeed;
    });
  }

  onToggleFullScreen() {
    youtubeController!.toggleFullScreenMode();
    isFullScreen.value = !isFullScreen.value;
    if (!youtubeController!.value.isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }

  onPlayPause() {
    if (isPlay.value) {
      isPlay.value = false;
      youtubeController!.pause();
    } else {
      isPlay.value = true;
      youtubeController!.play();
    }
    onTouch();
  }

  onTouch() {
    timer?.cancel();
    isTouch.value = !isTouch.value;
    isTouch.refresh();
    log(isTouch.value.toString());

    timer = Timer(Duration(seconds: 3), () {
      isTouch.value = false;
      timer!.cancel();
      log(isTouch.value.toString());
    });
  }
}
