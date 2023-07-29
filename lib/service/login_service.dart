import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class ServiceLogin {
  Future<void> kakaoLogin() async {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('KakaoAccount Login success');
    } catch (error) {
      print('KakaoAccount Login Error $error');
    }
  }

  Future<void> naverLogin() async {
    NaverLoginResult _result = await FlutterNaverLogin.logIn();
  }

  Future<void> googleLogin() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signIn();
  }
}
