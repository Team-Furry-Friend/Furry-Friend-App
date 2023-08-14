import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';

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
