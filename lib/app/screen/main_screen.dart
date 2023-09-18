import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/chat_list_screen.dart';
import 'package:furry_friend/app/screen/home_screen.dart';
import 'package:furry_friend/app/screen/seach_screen.dart';
import 'package:furry_friend/app/screen/setting_screen.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/providers/basket_provider.dart';
import 'package:furry_friend/domain/providers/user_provider.dart';
import 'package:provider/provider.dart';

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
    const ChatListScreen(),
    const SettingScreen()
  ];

  int currentTab = 0;

  @override
  void initState() {
    context.read<BasketProvider>().getMyBaskets();
    context.read<UserProvider>().userTokenRefresh();
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
                      color: index == currentTab ? WidgetColor.mainColor : deepGray,
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

  void typeOnTap(String type) {
    setState(() {
      screens[1] = SearchScreen(selectLabel: type);
      currentTab = 1;
    });
  }
}
