import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();

  factory Prefs() => _instance;

  late SharedPreferences sharedPrefs;

  Prefs._internal() {
    settingPref();
  }

  Future<void> settingPref() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }


  final String refreshToken = "REFRESHTOKEN";
  final String accessToken = "ACCESSTOKEN";

}