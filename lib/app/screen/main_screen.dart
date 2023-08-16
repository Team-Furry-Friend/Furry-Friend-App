import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/home_screen.dart';
import 'package:furry_friend/app/screen/seach_screen.dart';
import 'package:furry_friend/app/widget/color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bucket = PageStorageBucket();
  List<Widget> screens = [
    HomeScreen(typeOnTap: (index) {}),
    SearchScreen(),
    Container(),
    Container()
  ];

  int currentTab = 0;

  @override
  void initState() {
    screens[0] = HomeScreen(typeOnTap: typeOnTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: screens[currentTab],
      ),
      bottomNavigationBar: Wrap(
        children: [
          const Divider(
            height: 1,
            color: Colors.black45,
          ),
          BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (int index) {
              setState(() {
                currentTab = index;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              for (int index = 0; index < screens.length; index++)
                BottomNavigationBarItem(
                    icon: Icon(
                      tabIcon(index),
                      size: 32,
                      color: index == currentTab ? mainColor : deepGray,
                    ),
                    label: '')
            ],
          ),
        ],
      ),
    );
  }

  IconData tabIcon(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.home;
      case 1:
        return CupertinoIcons.cart;
      case 2:
        return CupertinoIcons.chat_bubble_text;
      case 3:
        return CupertinoIcons.person;
    }

    return CupertinoIcons.home;
  }

  void typeOnTap(int index) {
    setState(() {
      screens[1] = SearchScreen(selectLabelIndex: index);
      currentTab = 1;
    });
  }
}
