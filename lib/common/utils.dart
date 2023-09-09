import 'package:flutter/material.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static final Utils util = Utils();

  Future<void> serviceSetting() async {
    await PrefsUtils.init();
    kakao.KakaoSdk.init(
      nativeAppKey: '2b171fd1be0956ce61a994f5d910834e',
    );
  }

  bool isLogin() {
    return (PrefsUtils.getString(PrefsUtils.utils.email) ?? '').isNotEmpty;
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
      content: Text(text),
    ));
  }

  bool isValidEmailFormat(String text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} 분전';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} 시간 전';
    } else {
      return '${date.year}.${date.month}.${date.day}';
    }
  }
}
