import 'package:flutter/material.dart';
import 'package:furry_friend/screen/login_screen.dart';
import 'package:furry_friend/widget/common_widget.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: '2b171fd1be0956ce61a994f5d910834e',
  );

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
