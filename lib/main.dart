import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furry_friend/app/my_app.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/providers/basket_provider.dart';
import 'package:furry_friend/domain/providers/chat_provider.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:provider/provider.dart';

import 'domain/providers/search_provider.dart';
import 'domain/providers/user_provider.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');
  await Utils.util.serviceSetting();
  Future.delayed(Duration.zero, () {
    themeNotifier.value = PrefsUtils.getBool(PrefsUtils.utils.darkMode)
        ? ThemeMode.dark
        : ThemeMode.light;
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
      ChangeNotifierProvider(create: (_) => BasketProvider()),
    ],
    child: const MyApp(),
  ));
}
