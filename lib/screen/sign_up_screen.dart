import 'package:flutter/material.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/widget/color.dart';
import 'package:furry_friend/widget/common_widget.dart';
import 'package:furry_friend/widget/sign_up_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isCheckToS = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: DefaultAppBar(context,
          title: const Text(
            "회원가입",
            style: TextStyle(color: mainBlack, fontWeight: FontWeight.w500),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SignTextFieldRow(
                      icon: Icons.alternate_email_rounded, hintText: "이메일",controller: emailController,),
                  SignTextFieldRow(
                      icon: Icons.vpn_key_outlined, hintText: "비밀번호",controller: pwController,),
                  SignTextFieldRow(
                      icon: Icons.phone_outlined, hintText: "전화번호",controller: phoneController,),
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isCheckToS,
                        onChanged: (isCheck) {
                          if (isCheck != null) {
                            if (!isCheckToS) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return BottomSheetLayout(onTap: (){
                                      setState(() {
                                        isCheckToS = isCheck;
                                      });
                                      Navigator.pop(context);
                                    });
                                  });
                            } else {
                              setState(() {
                                isCheckToS = false;
                              });
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.3)),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                              width: 1.0, color: Color(0xffB9B9B9)),
                        ),
                        activeColor: mainColor,
                      ),
                      const Text(
                        "이용약관 및 개인정보 처리방침에 동의합니다.",
                        style: TextStyle(fontSize: 16, color: mainBlack),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: deepGray,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BottomButton(text: "다음", onTap: () {
                    if(!completeCheck()){
                      Utils().showSnackBar(context, "입력란 및 이용약관 동의를 확인해주세요.");
                    }
                  },
                  backgroundColor: completeCheck() ?  mainColor :  deepGray,),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  bool completeCheck(){
    return isCheckToS &&
        pwController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty;
  }
}
