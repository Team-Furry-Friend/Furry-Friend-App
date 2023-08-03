import 'package:flutter/material.dart';
import 'package:furry_friend/service/prefs.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class Utils {
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
      content: Text(text),
    ));
  }

  Future<void> serviceSetting() async {
    Prefs();
    KakaoSdk.init(
      nativeAppKey: '2b171fd1be0956ce61a994f5d910834e',
    );
  }

  bool isValidEmailFormat(String text) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }
}