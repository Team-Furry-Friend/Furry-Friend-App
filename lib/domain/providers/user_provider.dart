import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/home_screen.dart';
import 'package:furry_friend/app/screen/main_screen.dart';
import 'package:furry_friend/domain/model/user/token.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/model/user/user.dart';

import '../api/api.dart';

class UserProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  User _socialUser = User();
  User get socialUser => _socialUser;

  void signUpUser(BuildContext context, String email, String password,
      String name, String address, String phone) {
    _client.join(email, password, name, address, phone).then((value) {
      setPrefsUser(context, false, email, password,
          name: name, address: address, phone: phone);
    });
  }

  void loginUser(BuildContext context, String email, String password,
      {bool isLoginScreen = false}) {
    _client.login(email, password).then((value) {
      _client.setClientRefreshToken(value.refreshToken);

      if (isLoginScreen) {
        _client.userVerify({"Authorization": value.refreshToken}).then((value) {
          PrefsUtils.setString(PrefsUtils.utils.nickName, value.memberName);
          PrefsUtils.setInt(PrefsUtils.utils.userId, value.memberId);
        });
        setPrefsUser(context, true, email, password, token: value);
      }
    });
  }

  void socialLogin(BuildContext context, String social, String kakaoCode) {
    _client.socialLogin(social, kakaoCode).then((value) {
      _socialUser = value;
      PrefsUtils.setInt(PrefsUtils.utils.userId, _socialUser.mid);
    });
  }

  void userInfoPatch(BuildContext context, int mid, String name, String address,
      String phone) {
    _client.userInfoPatch(mid, name, address, phone).then((value) {
      setPrefsUser(context, false, _socialUser.email, _socialUser.mpw,
          token: value, name: name, address: address, phone: phone);
    });
  }

  void setPrefsUser(
      BuildContext context, bool isLogin, String email, String password,
      {String name = '',
      String address = '',
      String phone = '',
      Token? token}) {
    final prefs = PrefsUtils.utils;

    PrefsUtils.setString(prefs.email, email);
    PrefsUtils.setString(prefs.password, password);
    if (!isLogin) {
      PrefsUtils.setString(prefs.phoneNumber, phone);
      PrefsUtils.setString(prefs.nickName, name);
      PrefsUtils.setString(prefs.address, address);
    } else if (isLogin && token != null) {
      PrefsUtils.setString(prefs.refreshToken, token.refreshToken);
      PrefsUtils.setString(prefs.accessToken, token.accessToken);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }
}
