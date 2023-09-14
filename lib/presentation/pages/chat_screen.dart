import 'package:flutter/material.dart';
import 'package:hakathon_service/presentation/pages/chat/rooms.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return RoomsPage();
  }
}
