import 'package:flutter/material.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:provider/provider.dart';

import '../widget/color.dart';
import '../widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Expanded(child: HomeSearchWidget()),
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
          Expanded(
            child: Container(
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
