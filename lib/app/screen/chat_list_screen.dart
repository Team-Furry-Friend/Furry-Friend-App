import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/chat_widget.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/domain/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatProvider>().getChats();
  }

  @override
  Widget build(BuildContext context) {
    final chatList =
        context.select((ChatProvider provider) => provider.chatList);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 24, top: 40),
            child: Text(
              '채팅',
              style: TextStyle(
                color: mainBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final chatData = chatList[index].chatMessageResponseDTO;
              if (chatData != null) {
                return ChatRoomItem(
                    chatData: chatData, chatRoom: chatList[index]);
              }

              return Container();
            },
          ))
        ],
      ),
    );
  }
}
