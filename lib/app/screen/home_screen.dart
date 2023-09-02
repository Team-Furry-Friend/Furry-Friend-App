import 'package:flutter/material.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:furry_friend/domain/providers/user_provider.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:provider/provider.dart';

import '../widget/color.dart';
import '../widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.typeOnTap}) : super(key: key);

  Function(int index) typeOnTap;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final typeList = [
    '사료',
    '간식',
    '용품',
    '의류',
  ];

  @override
  void initState() {
    context.read<PostProvider>().getPopularityPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
            child: Row(
              children: [
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'Furry Fruend',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int index = 0; index < typeList.length; index++)
                  GestureDetector(
                    child: TypeRowItem(type: typeList[index]),
                    onTap: () => widget.typeOnTap(index),
                  )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 33),
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const SingleChildScrollView(child: PopularPostLayout()),
            ),
          ),
        ],
      ),
    );
  }
}
