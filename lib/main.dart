import 'package:flutter/material.dart';
import 'package:steaming_app_poc/screens/youtube_and_chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YouTubeAndChatScreen(),
    );
  }
}
