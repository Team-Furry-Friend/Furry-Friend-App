import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/chat_details_screen.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/model/chat/chat.dart';
import 'package:furry_friend/domain/model/chat/chat_message.dart';
import 'package:go_router/go_router.dart';

class ChatRoomItem extends StatelessWidget {
  const ChatRoomItem({
    super.key,
    required this.chatData,
    required this.chatRoom,
  });

  final ChatMessage chatData;
  final Chat chatRoom;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('chatDetails', pathParameters: {
          "roomId":
              "${chatRoom.chatParticipantsResponseDTO?.chatRoomResponseDTO?.chatRoomId ?? 0}"
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    chatData.chatMessageSerderName,
                    style: TextStyle(
                      color: WidgetColor.mainBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  Utils.util.formatDate(DateTime.parse(chatData.modDate)),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF868686),
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(minHeight: 38),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Row(
              children: [
                Expanded(child: Text(chatData.chatMessageContent)),
                Visibility(
                  visible: chatRoom.notReadCount > 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: WidgetColor.mainColor,
                        borderRadius: BorderRadius.circular(100)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    child: Text(
                      chatRoom.notReadCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatMessageItem extends StatelessWidget {
  const ChatMessageItem({
    super.key,
    required this.isMyMessage,
    required this.message,
  });

  final bool isMyMessage;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: Column(
        crossAxisAlignment:
            isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isMyMessage ? lightGray : Colors.white,
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
            child: Text(
              message.chatMessageContent,
              style: const TextStyle(height: 1.4),
            ),
          ),
          Text(
            Utils.util.formatDate(DateTime.parse(message.modDate)),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF868686),
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
