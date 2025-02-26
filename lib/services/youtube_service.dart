import 'package:dio/dio.dart';

class YouTubeService {
  final String apiKey;
  YouTubeService({required this.apiKey});
  static final Dio dio = Dio();

  Future<String> getLiveChatId(String liveBroadcastId) async {
    final url =
        'https://www.googleapis.com/youtube/v3/videos?part=liveStreamingDetails&id=$liveBroadcastId&key=$apiKey';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data;
      return data['items'][0]['liveStreamingDetails']['activeLiveChatId'];
    } else {
      throw Exception('Failed to get live chat ID');
    }
  }

  Future<Map<String, dynamic>> getLiveChatMessages(String liveChatId,
      {String? pageToken}) async {
    final url =
        'https://www.googleapis.com/youtube/v3/liveChat/messages?liveChatId=$liveChatId&part=snippet,authorDetails&key=$apiKey${pageToken != null ? '&pageToken=$pageToken' : ''}';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data;
      return data;
    } else {
      throw Exception('Failed to get live chat messages');
    }
  }
}
