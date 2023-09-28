import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/api/private_values.dart';
import 'package:furry_friend/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Utils {
  static final Utils util = Utils();

  Future<void> serviceSetting() async {
    await PrefsUtils.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  }

  bool isLogin() {
    return PrefsUtils.getInt(PrefsUtils.utils.userId) != 0;
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
