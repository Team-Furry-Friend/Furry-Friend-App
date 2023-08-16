import 'package:flutter/material.dart';

import '../screen/home_screen.dart';
import 'color.dart';

PreferredSizeWidget DefaultAppBar(BuildContext context, {Widget? title}) {
  return AppBar(
    elevation: 0,
    title: title,
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 18),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
        ),
      ),
    ),
  );
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.backgroundColor = const Color(0xFF70A3F3),
  });

  final Function() onTap;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldRow extends StatelessWidget {
  const TextFieldRow(
      {super.key,
      required this.icon,
      required this.hintText,
      required this.controller,
      this.inputType = TextInputType.text});

  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;

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
              controller: controller,
              obscureText: hintText == '비밀번호',
              keyboardType: inputType,
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
