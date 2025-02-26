import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeScreen2 extends StatefulWidget {
  const YoutubeScreen2({super.key});

  @override
  State<YoutubeScreen2> createState() => _YoutubeScreen2State();
}

class _YoutubeScreen2State extends State<YoutubeScreen2> {
// If the requirement is just to play a single video.
  final _controller = YoutubePlayerController.fromVideoId(
    videoId: 'AwADova6jNU',
    autoPlay: true,
    params: const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
