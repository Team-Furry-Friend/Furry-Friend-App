class ChatRoom {
  int chatRoomId = 0;
  String chatName = '';
  int chatCreator = 0;
  bool chatDel = false;

  ChatRoom(
      {this.chatRoomId = 0,
      this.chatName = '',
      this.chatCreator = 0,
      this.chatDel = false});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    chatRoomId = json['chatRoomId'];
    chatName = json['chatName'];
    chatCreator = json['chatCreator'] ?? 0;
    chatDel = json['chatDel'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRoomId'] = chatRoomId;
    data['chatName'] = chatName;
    data['chatCreator'] = chatCreator;
    data['chatDel'] = chatDel;
    return data;
  }
}
