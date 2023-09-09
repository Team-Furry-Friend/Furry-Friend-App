import 'package:flutter/material.dart';
import 'package:furry_friend/domain/api/api.dart';
import 'package:furry_friend/domain/model/chat/chat.dart';

class ChatProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Chat> _chatList = [];
  List<Chat> get chatList => _chatList;

  void getChats() {
    _client.getChats().then((value) {
      value.sort((b, a) => a.chatMessageResponseDTO!.modDate
          .compareTo(b.chatMessageResponseDTO!.modDate));
      _chatList = value;
      notifyListeners();
    });
  }
}
