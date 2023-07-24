import 'package:flutter/material.dart';
import 'package:furry_friend/screen/home_screen.dart';
import 'package:furry_friend/widget/color.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _screenList = <Widget>[
    const HomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screenList.elementAt(_selectedIndex),
      ),
      // bottom navigation 선언
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'user'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: mainColor,
        unselectedItemColor: lightGray,
        onTap: _onTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
