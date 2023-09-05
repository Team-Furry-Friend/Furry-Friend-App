import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../screen/home_screen.dart';
import 'color.dart';

PreferredSizeWidget DefaultAppBar(BuildContext context,
    {Widget? title, List<Widget>? actions}) {
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
    actions: actions,
  );
}

class BottomButtonLayout extends StatelessWidget {
  const BottomButtonLayout({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
  });

  final Function() onTap;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: deepGray,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BottomButton(
            text: text,
            onTap: () => onTap(),
            backgroundColor: backgroundColor,
          ),
        )
      ],
    );
  }
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

class GrayTextFieldLayout extends StatelessWidget {
  const GrayTextFieldLayout({
    super.key,
    required this.textController,
    required this.hintText,
    this.marginValue = 24,
    this.maxLines = 1,
  });

  final TextEditingController textController;
  final String hintText;
  final double marginValue;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginValue),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(16)),
      child: TextField(
          controller: textController,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
            hintStyle: const TextStyle(
              color: Color(0xFFB8B8B8),
              fontWeight: FontWeight.w500,
            ),
          )),
    );
  }
}

class TextLabelLayout extends StatelessWidget {
  const TextLabelLayout({
    super.key,
    required this.selectLabel,
    required this.labelOnTap,
  });

  final String selectLabel;
  final Function(String) labelOnTap;
  final typeList = const [
    '사료',
    '간식',
    '용품',
    '의류',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: typeList.length,
          itemBuilder: (context, index) {
            final type = typeList[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TypeLabel(
                type: type,
                isSelectedLabel: selectLabel == type,
                onTap: () => labelOnTap(type),
              ),
            );
          }),
    );
  }
}

class TypeLabel extends StatelessWidget {
  const TypeLabel({
    super.key,
    required this.type,
    required this.isSelectedLabel,
    required this.onTap,
  });

  final String type;
  final bool isSelectedLabel;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
            color: isSelectedLabel ? mainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF70A3F3), width: 1)),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 15,
            color: isSelectedLabel ? Colors.white : const Color(0xFF70A3F3),
          ),
        ),
      ),
    );
  }
}
