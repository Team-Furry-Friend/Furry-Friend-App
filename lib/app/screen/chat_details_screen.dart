import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/chat_widget.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/providers/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key, required this.roomId});

  final int roomId;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final _messageTextController = TextEditingController();
  final _scrollController = ScrollController();

  int userId = 0;
  StompClient? stompClient;

  @override
  void initState() {
    super.initState();
    userId = PrefsUtils.getInt(PrefsUtils.utils.userId);
    context.read<ChatProvider>().getMessages(widget.roomId);
    sokectEventSetting();
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    stompClient?.send(
        destination: '', body: json.encode({'type': 'disconnect'}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessage =
        context.select((ChatProvider provider) => provider.chatMessagePage);
    return Scaffold(
        appBar: DefaultAppBar(context,
            title: Text(
              "채팅",
              style: TextStyle(
                  color: WidgetColor.mainBlack, fontWeight: FontWeight.w500),
            )),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: chatMessage.dtoList.length,
                  itemBuilder: (context, index) {
                    final message = chatMessage.dtoList[index];
                    final isMyMessage = userId == message.chatMessageSenderId;
                    return ChatMessageItem(
                        isMyMessage: isMyMessage, message: message);
                  }),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.zero,
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: GrayTextFieldLayout(
                          textController: _messageTextController,
                          verticalPadding: 4,
                          hintText: '메세지를 적어주세요.',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => sendMessage(),
                        child: Container(
                          margin: const EdgeInsets.only(right: 24),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: WidgetColor.mainColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  void onConnect(StompFrame frame) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
    stompClient!.subscribe(
        destination: '/sub/chats/${widget.roomId}',
        callback: (StompFrame frame) =>
            context.read<ChatProvider>().getNewMessage(frame));
  }

  void sendMessage() {
    setState(() {
      stompClient!.send(
          destination: '/pub/chats/${widget.roomId}',
          body: json.encode({
            "content": _messageTextController.text,
          }));
      _messageTextController.clear();
    });
  }

  void sokectEventSetting() {
    if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.sockJS(
        url: 'http://howstheairtoday.site/chats/furry',
        onConnect: onConnect,
        webSocketConnectHeaders: {
          'Upgrade': 'websocket',
          'Connection': 'Upgrade',
          'transports': ['polling', 'websocket'],
        },
        stompConnectHeaders: {
          'Authorization': PrefsUtils.getString(PrefsUtils.utils.refreshToken),
        },
        onWebSocketError: (dynamic error) {
          print('onWebSocketError ${error.toString()}');
        },
      ));
      stompClient!.activate();
    }
  }
}
