import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.inputType = TextInputType.text});

  final TextInputType inputType;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFB8B8B8),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ));
  }
}

class ProductWriteFrame extends StatelessWidget {
  const ProductWriteFrame(
      {super.key, required this.titleText, required this.childWidget});

  final String titleText;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            titleText,
            style: const TextStyle(
              color: mainBlack,
              fontSize: 16,
            ),
          ),
        ),
        childWidget
      ],
    );
  }
}
