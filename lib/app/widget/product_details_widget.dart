import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';

class ProductInfoFrame extends StatelessWidget {
  const ProductInfoFrame(
      {super.key, required this.children, this.dividerVisible = true});

  final List<Widget> children;
  final bool dividerVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            )),
        Visibility(
          visible: dividerVisible,
          child: const Divider(
            thickness: 14,
            color: backgroundColor,
          ),
        )
      ],
    );
  }
}
