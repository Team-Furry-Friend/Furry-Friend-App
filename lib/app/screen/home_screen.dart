import 'package:flutter/material.dart';

import '../widget/color.dart';
import '../widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          '최근 등록된 상품 🚀',
                          style: TextStyle(
                            color: mainBlack,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      RoundBlueButton(text: '모두보기'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeListItem();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
