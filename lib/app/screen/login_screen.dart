import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furry_friend/app/screen/login_email_screen.dart';
import 'package:furry_friend/app/screen/sign_up_screen.dart';
import 'package:furry_friend/app/screen/web_view_screen.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:go_router/go_router.dart';

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
            const Padding(
              padding: EdgeInsets.only(bottom: 120),
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
                    key: Key('${element}LoginButton'),
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
                context.goNamed('signUp', pathParameters: {
                  "loginType": "email",
                  "isSocialSign": "false",
                });
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
      context.goNamed('loginEmail');
      return;
    }
    if (kIsWeb) {
      Utils.util.showSnackBar(context, '현재 웹에서는 해당 기능을 제공하지 않습니다.');
      return;
    }
    final redirectUrl = '${dotenv.env['FURRY_FRIEND_URL'] ?? ""}$type';
    String socialLoginUrl = '';

    switch (type) {
      case "kakao":
        socialLoginUrl =
            '${dotenv.env['KAKAO_LOGIN_URL'] ?? ""}$redirectUrl&response_type=code';
        break;
      case "naver":
        socialLoginUrl =
            '${dotenv.env['NAVER_LOGIN_URL'] ?? ""}$redirectUrl';
        break;
      case "google":
        socialLoginUrl =
            '${dotenv.env['GOOGLE_LOGIN_URL'] ?? ""}$redirectUrl&response_type=code&scope=email';
        break;
    }

    context.goNamed('webView', pathParameters: {
      "siteUrl": socialLoginUrl,
      "socialType": type,
    });
  }
}
