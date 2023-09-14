import 'package:furry_friend/domain/model/chat/chat_room.dart';

class ChatParticipants {
  int chatParticipantsId = 0;
  int chatParticipantsMemberId = 0;
  String chatParticipantsMemberName = '';
  bool chatParticipantsDel = false;
  ChatRoom? chatRoomResponseDTO = ChatRoom();

  ChatParticipants(
      {this.chatParticipantsId = 0,
      this.chatParticipantsMemberId = 0,
      this.chatParticipantsMemberName = '',
      this.chatParticipantsDel = false,
      this.chatRoomResponseDTO});

  ChatParticipants.fromJson(Map<String, dynamic> json) {
    chatParticipantsId = json['chatParticipantsId'];
    chatParticipantsMemberId = json['chatParticipantsMemberId'];
    chatParticipantsMemberName = json['chatParticipantsMemberName'];
    chatParticipantsDel = json['chatParticipantsDel'];
    chatRoomResponseDTO = json['chatRoomResponseDTO'] != null
        ? ChatRoom.fromJson(json['chatRoomResponseDTO'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatParticipantsId'] = chatParticipantsId;
    data['chatParticipantsMemberId'] = chatParticipantsMemberId;
    data['chatParticipantsMemberName'] = chatParticipantsMemberName;
    data['chatParticipantsDel'] = chatParticipantsDel;
    if (chatRoomResponseDTO != null) {
      data['chatRoomResponseDTO'] = chatRoomResponseDTO!.toJson();
    }
    return data;
  }
}
