import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class YoutubeLiveChat extends StatefulWidget {
  const YoutubeLiveChat({super.key});

  @override
  State<YoutubeLiveChat> createState() => _YoutubeLiveChatState();
}

class _YoutubeLiveChatState extends State<YoutubeLiveChat> {
  String videoId = '8w65NghcuR8';
  String liveChatId = '';
  String apiKey = '';
  final Dio _dio = Dio();
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  Timer? _pollingTimer;
  int pollingIntervalMillis = 5000;
  String nextPageToken = "";

  Future getLiveChatId() async {
    final url =
        'https://www.googleapis.com/youtube/v3/videos?part=liveStreamingDetails&id=$videoId&key=$apiKey';
    final response = await _dio.get(url);
    final data = response.data;
    final idChat = data['items'][0]['liveStreamingDetails']['activeLiveChatId'];

    // pollingIntervalMillis = data['pollingIntervalMillis'];
    liveChatId = idChat;

    // startPolling();
    getChatMessages();
  }

  Future getChatMessages() async {
    final url =
        'https://www.googleapis.com/youtube/v3/liveChat/messages?liveChatId=$liveChatId&part=snippet,authorDetails&key=$apiKey&pageToken=$nextPageToken';
    final response = await _dio.get(url);

    final prettyString =
        const JsonEncoder.withIndent('  ').convert(response.data);
    log(prettyString);
    final data = response.data;
    nextPageToken = data['nextPageToken'];
    final items = data['items'] as List;
    setState(() {
      // _messages.clear();
      for (var item in items) {
        _messages.add(item['snippet']['displayMessage'] ?? "");
      }
    });
  }

  Future sendMessage(String message) async {
    final url =
        'https://www.googleapis.com/youtube/v3/liveChat/messages?part=snippet';
    final response = await _dio.post(url,
        data: {
          'snippet': {
            'liveChatId': liveChatId,
            'type': 'textMessageEvent',
            'textMessageDetails': {'messageText': message}
          }
        },
        options: Options(headers: {
          'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
          'Content-Type': 'application/json'
        }));

    if (response.statusCode == 200) {
      log('Message sent: $message');
    } else {
      log('Failed to send message: ${response.statusCode}');
    }
  }

  void startPolling() {
    _pollingTimer =
        Timer.periodic(Duration(milliseconds: pollingIntervalMillis), (timer) {
      getChatMessages();
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  @override
  void initState() {
    getLiveChatId();
    super.initState();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Enter your message',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sendMessage(_messageController.text);
                _messageController.clear();
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
