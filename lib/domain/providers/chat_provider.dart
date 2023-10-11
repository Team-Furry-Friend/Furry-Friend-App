import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/chat_details_screen.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/api/api.dart';
import 'package:furry_friend/domain/model/chat/chat.dart';
import 'package:furry_friend/domain/model/chat/chat_message.dart';
import 'package:furry_friend/domain/model/chat/chat_message_page.dart';
import 'package:go_router/go_router.dart';
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
      value.removeWhere(
          (element) => element.chatMessageResponseDTO?.chatMessageId == 0);
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

  void createChatRoom(BuildContext context, int id) {
    final options = {
      "chatParticipantsId": id,
      "chatParticipantsName": PrefsUtils.getString(PrefsUtils.utils.nickName),
      "jwtRequest": {
        "access_token": PrefsUtils.getString(PrefsUtils.utils.refreshToken)
      }
    };

    _client.postChat(options).then((value) {
      if (value.chatRoomResponseDTO != null) {
        context.goNamed('chatDetails', pathParameters: {
          "roomId": "${value.chatRoomResponseDTO!.chatRoomId}"
        });
      }
    });
  }

  void sendNewMessage() {}
}
