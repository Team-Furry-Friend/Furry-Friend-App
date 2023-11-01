import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/config/route.dart';
import 'package:furry_friend/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, child) {
          WidgetColor.isDarkMode = currentMode == ThemeMode.dark;
          return WebMobileSizeMatchLayout(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Furry Friend',
                theme: ThemeData(fontFamily: 'Pretendard'),
                darkTheme: ThemeData.dark(),
                themeMode: currentMode,
                routerConfig: router,
              ));
        });
  }
}
