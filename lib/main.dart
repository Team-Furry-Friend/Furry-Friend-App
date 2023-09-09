import 'package:flutter/material.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/providers/chat_provider.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:provider/provider.dart';

import 'app/screen/login_screen.dart';
import 'app/screen/main_screen.dart';
import 'domain/providers/search_provider.dart';
import 'domain/providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Utils.util.serviceSetting();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
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
      home: Utils.util.isLogin() ? const MainScreen() : LoginScreen(),
    );
  }
}
