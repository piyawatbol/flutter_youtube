import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steaming_app_poc/controllers/youtube_and_chat_controller.dart';
import 'package:steaming_app_poc/models/youtube_chat_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/status_loading.dart';

class YouTubeAndChatScreen extends GetView<YoutubeAndChatController> {
  const YouTubeAndChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(YoutubeAndChatController());
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: controller.youtubeController!,
                ),
                builder: (context, player) {
                  return Stack(
                    children: [
                      Center(child: player),
                      Obx(
                        () => Positioned.fill(
                          child: GestureDetector(
                            onTap: () {
                              controller.onTouch();
                            },
                            child: AnimatedContainer(
                              duration: Duration(
                                  milliseconds:
                                      controller.isTouch.value ? 300 : 500),
                              color: controller.isTouch.value
                                  ? Colors.black38
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.isTouch.value ||
                              !controller.isPlay.value,
                          child: Positioned.fill(
                            child: GestureDetector(
                              onTap: () {
                                controller.onPlayPause();
                              },
                              child: Icon(
                                size: 50,
                                controller.isPlay.value
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.isTouch.value,
                          child: Positioned(
                            right: 10,
                            bottom: 10,
                            child: GestureDetector(
                              onTap: () {
                                controller.onToggleFullScreen();
                              },
                              child: Icon(
                                size: 30,
                                controller.isFullScreen.value
                                    ? Icons.fullscreen_exit
                                    : Icons.fullscreen,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                child: controller.chatLoading.value == StatusLoading.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: controller.messageList.length,
                        itemBuilder: (context, index) {
                          Item message = controller.messageList[index];
                          return Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  message.authorDetails.profileImageUrl,
                                ),
                              ),
                              title: Text(message.authorDetails.displayName),
                              subtitle: Text(message.snippet.displayMessage),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
