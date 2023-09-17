import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/basket_list_widget.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/widget_color.dart';

class BasketListScreen extends StatefulWidget {
  const BasketListScreen({super.key});

  @override
  State<BasketListScreen> createState() => _BasketListScreenState();
}

class _BasketListScreenState extends State<BasketListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WidgetColor.cleanWhite,
      appBar: DefaultAppBar(context,
          title: Text(
            "찜 목록",
            style: TextStyle(
                color: WidgetColor.mainBlack, fontWeight: FontWeight.w500),
          )),
      body: const Padding(
        padding: EdgeInsets.only(top: 12),
        child: BasketListLayout(),
      ),
    );
  }
}
