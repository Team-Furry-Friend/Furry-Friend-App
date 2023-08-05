import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/home_screen.dart';
import 'package:furry_friend/domain/model/user/token.dart';
import 'package:furry_friend/service/prefs.dart';

import '../api/api.dart';

class User extends ChangeNotifier {
  final _client = ApiRepositories();
  final prefs = Prefs();

  void signUpUser(BuildContext context, String email, String password,
      String name, String address, String phone) {
    _client.join(email, password, name, address, phone).then((value) {
      setPrefsUser(context, false, email, password,
          name: name, address: address, phone: phone);
    });
  }

  void loginUser(BuildContext context, String email, String password) {
    _client.login(email, password).then((value) {
      setPrefsUser(context, true, email, password, token: value);
    });
  }

  void setPrefsUser(
      BuildContext context, bool isLogin, String email, String password,
      {String name = '',
      String address = '',
      String phone = '',
      Token? token}) {
    final sharedPrefs = prefs.sharedPrefs;

    sharedPrefs.setString(prefs.email, email);
    sharedPrefs.setString(prefs.password, password);
    if (!isLogin) {
      sharedPrefs.setString(prefs.phoneNumber, phone);
      sharedPrefs.setString(prefs.nickName, name);
      sharedPrefs.setString(prefs.address, address);
    } else if (isLogin && token != null) {
      sharedPrefs.setString(prefs.refreshToken, token.refreshToken);
      sharedPrefs.setString(prefs.accessToken, token.accessToken);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
