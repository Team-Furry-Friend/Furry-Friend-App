import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:provider/provider.dart';

import 'app/screen/login_screen.dart';
import 'app/screen/main_screen.dart';
import 'domain/providers/search_provider.dart';
import 'domain/providers/user_provider.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Utils.util.serviceSetting();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, child) {
          WidgetColor.isDarkMode = currentMode == ThemeMode.dark;
          return MaterialApp(
            title: 'Furry Friend',
            theme: ThemeData(fontFamily: 'Pretendard'),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: Utils.util.isLogin() ? const MainScreen() : LoginScreen(),
          );
        });
  }

  void setThemeMode() {
    Future.delayed(Duration.zero, () {
      themeNotifier.value = PrefsUtils.getBool(PrefsUtils.utils.darkMode)
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }
}
