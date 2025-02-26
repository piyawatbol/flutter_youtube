import 'package:flutter/material.dart';
import 'package:youtube_player_embed/controller/video_controller.dart';
import 'package:youtube_player_embed/youtube_player_embed.dart';

class YoutubeScreen3 extends StatefulWidget {
  const YoutubeScreen3({super.key});

  @override
  State<YoutubeScreen3> createState() => _YoutubeScreen3State();
}

class _YoutubeScreen3State extends State<YoutubeScreen3> {
  VideoController? videoController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            YoutubePlayerEmbed(
              callBackVideoController: (controller) {
                videoController = controller;
              },
              videoId: "IYdXDar0mVs",
              autoPlay: true,

              // hidenVideoControls: true,
              mute: true,
              enabledShareButton: false,
              // hidenChannelImage: true,
              aspectRatio: 16 / 9,
              onVideoEnd: () {
                print("video ended");
              },
              onVideoSeek: (currentTime) =>
                  print("Seeked to $currentTime seconds"),
              onVideoTimeUpdate: (currentTime) =>
                  print("Current time: $currentTime seconds"),
            ),
            GestureDetector(
              onTap: () {
                videoController!.playVideo();
              },
              child: Container(
                height: 200,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
