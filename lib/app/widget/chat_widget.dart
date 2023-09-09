import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/chat_details_screen.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/model/chat/chat.dart';
import 'package:furry_friend/domain/model/chat/chat_message.dart';

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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ChatDetailsScreen()));
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
                    style: const TextStyle(
                      color: mainBlack,
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
                        color: mainColor,
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
