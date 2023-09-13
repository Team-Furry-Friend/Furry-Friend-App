import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/login_screen.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    darkMode = PrefsUtils.getBool(PrefsUtils.utils.darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PrefsUtils.getString(PrefsUtils.utils.nickName),
                  style: TextStyle(
                      color: WidgetColor.mainBlack,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    PrefsUtils.getString(PrefsUtils.utils.address),
                    style: const TextStyle(
                      color: deepGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  '다크모드',
                  style: TextStyle(fontSize: 16, color: WidgetColor.mainBlack),
                )),
                Switch(
                  value: darkMode,
                  activeColor: WidgetColor.mainColor,
                  onChanged: (bool value) {
                    setState(() {
                      darkMode = value;
                      PrefsUtils.setBool(PrefsUtils.utils.darkMode, value);
                      themeNotifier.value =
                          value ? ThemeMode.dark : ThemeMode.light;
                    });
                  },
                )
              ],
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              PrefsUtils.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              width: double.infinity,
              child: const Text(
                '로그아웃',
                style: TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}
