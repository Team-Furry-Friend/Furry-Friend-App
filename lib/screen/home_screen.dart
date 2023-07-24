import 'package:flutter/material.dart';
import 'package:furry_friend/widget/color.dart';
import 'package:furry_friend/widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        children: <Widget>[
          const HomeSearchWidget(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
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
                    padding: const EdgeInsets.only(top: 28),
                    child: SizedBox(
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeListItem();
                        },
                      ),
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
