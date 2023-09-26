import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furry_friend/domain/api/api.dart';
import 'package:furry_friend/domain/model/chat/chat.dart';
import 'package:furry_friend/domain/model/chat/chat_message.dart';
import 'package:furry_friend/domain/model/chat/chat_message_page.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Chat> _chatList = [];
  List<Chat> get chatList => _chatList;

  ChatMessagePage _chatMessagePage = ChatMessagePage();
  ChatMessagePage get chatMessagePage => _chatMessagePage;

  void getChats() {
    _client.getChats().then((value) {
      value.sort((b, a) => a.chatMessageResponseDTO!.modDate
          .compareTo(b.chatMessageResponseDTO!.modDate));
      _chatList = value;
      notifyListeners();
    });
  }

  void getMessages(int roomId) {
    _client.getMessages(roomId, DateTime.now().toIso8601String()).then((value) {
      value.dtoList.sort((a, b) => a.modDate.compareTo(b.modDate));
      _chatMessagePage = value;
      notifyListeners();
    });
  }

  void getNewMessage(StompFrame frame, {ChatMessage? message}) {
    if (frame.body != null) {
      Map<String, dynamic> obj = json.decode(frame.body!);
      if (obj["statusCode"] / 100 == 2) {
        message = ChatMessage.fromJson(obj["data"]);
      }
    }

    message ??= ChatMessage();

    _chatMessagePage.dtoList = [..._chatMessagePage.dtoList, message];
    notifyListeners();
  }

  void sendNewMessage() {}
}
