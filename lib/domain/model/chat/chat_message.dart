class ChatMessage {
  int chatMessageId = 0;
  int chatMessageSenderId = 0;
  String chatMessageSerderName = '';
  String chatMessageContent = '';
  bool chatMessageRead = false;
  bool chatMessageDel = false;
  String regDate = '';
  String modDate = '';

  ChatMessage(
      {this.chatMessageId = 0,
      this.chatMessageSenderId = 0,
      this.chatMessageSerderName = '',
      this.chatMessageContent = '',
      this.chatMessageRead = false,
      this.chatMessageDel = false,
      this.regDate = '',
      this.modDate = ''});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    chatMessageId = json['chatMessageId'];
    chatMessageSenderId = json['chatMessageSenderId'];
    chatMessageSerderName = json['chatMessageSerderName'];
    chatMessageContent = json['chatMessageContent'];
    chatMessageRead = json['chatMessageRead'];
    chatMessageDel = json['chatMessageDel'];
    regDate = json['regDate'] ?? '';
    modDate = json['modDate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatMessageId'] = chatMessageId;
    data['chatMessageSenderId'] = chatMessageSenderId;
    data['chatMessageSerderName'] = chatMessageSerderName;
    data['chatMessageContent'] = chatMessageContent;
    data['chatMessageRead'] = chatMessageRead;
    data['chatMessageDel'] = chatMessageDel;
    data['regDate'] = regDate;
    data['modDate'] = modDate;
    return data;
  }
}
