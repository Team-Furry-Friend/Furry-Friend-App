import 'package:furry_friend/domain/model/chat/chat_message.dart';

class ChatMessagePage {
  List<ChatMessage> dtoList = [];
  int totalPage = 0;
  int page = 0;
  int size = 0;
  int start = 0;
  int end = 0;
  bool prev = false;
  bool next = true;
  List<int> pageList = [];

  ChatMessagePage(
      {this.dtoList = const [],
      this.totalPage = 0,
      this.page = 0,
      this.size = 0,
      this.start = 0,
      this.end = 0,
      this.prev = false,
      this.next = true,
      this.pageList = const []});

  ChatMessagePage.fromJson(Map<String, dynamic> json) {
    if (json['dtoList'] != null) {
      dtoList = <ChatMessage>[];
      json['dtoList'].forEach((v) {
        dtoList!.add(ChatMessage.fromJson(v));
      });
    }
    totalPage = json['totalPage'];
    page = json['page'];
    size = json['size'];
    start = json['start'];
    end = json['end'];
    prev = json['prev'];
    next = json['next'];
    pageList = json['pageList'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (dtoList != null) {
      data['dtoList'] = dtoList!.map((v) => v.toJson()).toList();
    }
    data['totalPage'] = totalPage;
    data['page'] = page;
    data['size'] = size;
    data['start'] = start;
    data['end'] = end;
    data['prev'] = prev;
    data['next'] = next;
    data['pageList'] = pageList;
    return data;
  }
}
