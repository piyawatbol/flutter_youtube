import 'dart:async';

import 'package:flutter/material.dart';

import '../services/youtube_service.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  @override
  LiveChatScreenState createState() => LiveChatScreenState();
}

class LiveChatScreenState extends State<LiveChatScreen> {
  final String liveBroadcastId = 'e98BL-t46ao';
  YouTubeService? youtubeService;
  final List<dynamic> messageList = [];
  Timer? timer;
  String? nextPageToken;

  @override
  void initState() {
    super.initState();
    youtubeService =
        YouTubeService(apiKey: "AIzaSyABA9EDzgKSXtCuD0UIx86O7TOupRce7as");
    startPolling();
  }

  void startPolling() async {
    final liveChatId = await youtubeService!.getLiveChatId(liveBroadcastId);
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      final response = await youtubeService!
          .getLiveChatMessages(liveChatId, pageToken: nextPageToken);
      setState(() {
        messageList.addAll(response['items']);
        nextPageToken = response['nextPageToken'];
      });
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chat Messages'),
      ),
      body: ListView.builder(
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final message = messageList[index];
          return ListTile(
            title: Text(message['snippet']['displayMessage']),
            subtitle: Text(message['authorDetails']['displayName']),
          );
        },
      ),
    );
  }
}
