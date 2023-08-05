import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/home_screen.dart';
import 'package:furry_friend/service/prefs.dart';

import '../api/api.dart';

class User extends ChangeNotifier {
  final _client = ApiRepositories();
  final prefs = Prefs();

  void signUpUser(BuildContext context, String email, String password,
      String name, String address, String phone) {
    _client.join(email, password, name, address, phone).then((value) {
      final sharedPrefs = prefs.sharedPrefs;

      sharedPrefs.setString(prefs.email, email);
      sharedPrefs.setString(prefs.password, password);
      sharedPrefs.setString(prefs.phoneNumber, phone);
      sharedPrefs.setString(prefs.nickName, name);
      sharedPrefs.setString(prefs.address, address);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }
}
