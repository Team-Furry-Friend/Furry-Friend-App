import 'package:furry_friend/domain/model/chat/chat_message.dart';
import 'package:furry_friend/domain/model/chat/chat_participants.dart';

class Chat {
  ChatMessage? chatMessageResponseDTO = ChatMessage();
  ChatParticipants? chatParticipantsResponseDTO = ChatParticipants();
  int notReadCount = 0;

  Chat(
      {this.chatMessageResponseDTO,
      this.chatParticipantsResponseDTO,
      this.notReadCount = 0});

  Chat.fromJson(Map<String, dynamic> json) {
    chatMessageResponseDTO = json['chatMessageResponseDTO'] != null
        ? ChatMessage.fromJson(json['chatMessageResponseDTO'])
        : null;
    chatParticipantsResponseDTO = json['chatParticipantsResponseDTO'] != null
        ? ChatParticipants.fromJson(json['chatParticipantsResponseDTO'])
        : null;
    notReadCount = json['notReadCount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (chatMessageResponseDTO != null) {
      data['chatMessageResponseDTO'] = chatMessageResponseDTO!.toJson();
    }
    if (chatParticipantsResponseDTO != null) {
      data['chatParticipantsResponseDTO'] =
          chatParticipantsResponseDTO!.toJson();
    }
    data['notReadCount'] = notReadCount;
    return data;
  }
}
