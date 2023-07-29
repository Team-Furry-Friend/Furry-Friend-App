import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:furry_friend/widget/color.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginList = ['mail', 'kakao', 'naver', 'google'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: Text(
                "Furry Friend",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var element in loginList)
                  GestureDetector(
                    onTap: () => loginOnTap(element),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        'images/btn_${element}_login.png',
                        width: 55,
                      ),
                    ),
                  )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 124, vertical: 24),
              child: Divider(
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                '이메일 회원가입',
                style: TextStyle(
                  color: lightGray,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void loginOnTap(String element) {
    switch (element) {
      case "kakao":
        kakaoLogin();
      case "naver":
        naverLogin();
    }
  }

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
}
