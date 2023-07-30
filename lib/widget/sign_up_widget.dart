import 'package:flutter/material.dart';
import 'package:furry_friend/widget/color.dart';

class SignTextFieldRow extends StatelessWidget {
  const SignTextFieldRow({
    super.key,
    required this.icon,
    required this.hintText,
  });

  final IconData icon;
  final String hintText;

  final textStyle = const TextStyle(
    color: Color(0xFFB8B8B8),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: deepGray,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: textStyle,
                  focusColor: mainColor),
            ),
          ),
        ),
      ],
    );
  }
}
