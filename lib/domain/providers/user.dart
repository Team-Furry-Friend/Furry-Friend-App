import 'package:flutter/material.dart';
import 'package:furry_friend/service/prefs.dart';

import '../api/api.dart';

class User extends ChangeNotifier{
  final _client = ApiRepositories();
  final prefs = Prefs();

  void signUpUser(String email, String password){
    _client.join(email, password).then((value){
      prefs.sharedPrefs.setString(prefs.refreshToken, value.refreshToken);
      prefs.sharedPrefs.setString(prefs.accessToken, value.accessToken);
      print(value);
    });
  }
}