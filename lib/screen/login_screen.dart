import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furry_friend/widget/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginList = [
    'mail',
    'kakao',
    'naver',
    'google'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: Text("Furry Friend",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var element in loginList) GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset('images/btn_${element}_login.png',width: 55,),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 124,vertical: 24),
              child: Divider(thickness: 1,),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Text(
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
}

