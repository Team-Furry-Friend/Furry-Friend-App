import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/login_email_screen.dart';
import 'package:furry_friend/app/screen/sign_up_screen.dart';
import 'package:furry_friend/app/screen/web_view_screen.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/service/login_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

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
                        'assets/images/btn_${element}_login.png',
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen(
                              loginType: 'email',
                              isSocialSign: false,
                            )));
              },
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

  void loginOnTap(String type) {
    if (type == "mail") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginEmailScreen()));
    }
    final redirectUrl = 'https://furry-friend-kappa.vercel.app/oauth2/$type';
    String socialLoginUrl = '';

    switch (type) {
      case "kakao":
        socialLoginUrl =
            'https://kauth.kakao.com/oauth/authorize?client_id=a9fba49d1993fd773a9dc3bcaf08805c&redirect_uri=$redirectUrl&response_type=code';
        break;
      case "naver":
        socialLoginUrl =
            'https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=k630Wyb3TY8cxFgIdoIB&redirect_uri=$redirectUrl';
        break;
      case "google":
        socialLoginUrl =
            'https://accounts.google.com/o/oauth2/v2/auth?client_id=526477563372-29m9nrid0oq8mk2rfvkb5rd8j9iquq0k.apps.googleusercontent.com&redirect_uri=$redirectUrl&response_type=code&scope=email';
        break;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(
            siteUrl: socialLoginUrl,
            socialType: type,
          ),
        ));
  }
}
