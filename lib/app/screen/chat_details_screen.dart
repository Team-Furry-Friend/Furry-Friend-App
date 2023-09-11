import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furry_friend/common/prefs_utils.dart';
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
  StompClient? stompClient;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            sendMessage();
          },
          child: Text('메세지 전송'),
        ),
      ),
    );
  }

  void onConnect(StompFrame frame) {
    print('onConnect');
    stompClient!.subscribe(
        destination: '/sub/chats/${widget.roomId}',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> obj = json.decode(frame.body!);
            print(obj);
          }
        });
  }

  sendMessage() {
    setState(() {
      stompClient!.send(
          destination: '/pub/chats/${widget.roomId}',
          body: json.encode({
            "content": 'sendMessage',
          }));
    });
  }

  void sokectEventSetting() {
    if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.sockJS(
        url: 'https://howstheairtoday.site/chats/furry',
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
