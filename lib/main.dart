import 'package:flutter/material.dart';
import 'package:furry_friend/screen/login_screen.dart';
import 'package:furry_friend/widget/common_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Furry Friend',
      home: LoginScreen(),
    );
  }
}
