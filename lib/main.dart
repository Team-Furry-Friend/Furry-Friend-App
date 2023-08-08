import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/home_screen.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:provider/provider.dart';

import 'app/screen/login_screen.dart';
import 'domain/providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Utils().serviceSetting();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furry Friend',
      theme: ThemeData(fontFamily: 'Pretendard'),
      home: Utils().isLogin() ? const HomeScreen() : LoginScreen(),
    );
  }
}
