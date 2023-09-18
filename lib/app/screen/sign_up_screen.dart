import 'package:flutter/material.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:provider/provider.dart';

import '../../domain/providers/user_provider.dart';
import '../widget/widget_color.dart';
import '../widget/common_widget.dart';
import '../widget/sign_up_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
    required this.isSocialSign,
    required this.loginType,
  }) : super(key: key);

  final bool isSocialSign;
  final String loginType;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final UserProvider userProvider = UserProvider();
  final util = Utils();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isCheckToS = false;

  @override
  void initState() {
    if (widget.isSocialSign) {
      String type = widget.loginType;
      String kakaoCode = '';
      if (widget.loginType.startsWith('kakao')) {
        type = widget.loginType.split('|').first;
        kakaoCode = widget.loginType.split('|').last;
      }
      print('type:$type _ kakaoCode:$kakaoCode');
      userProvider.socialLogin(context, type, kakaoCode);
    }
    controllerListenerSetting();
    super.initState();
  }

  @override
  void dispose() {
    controllerListenerSetting(isDispose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: DefaultAppBar(context,
          title: Text(
            "회원가입",
            style: TextStyle(
                color: WidgetColor.mainBlack, fontWeight: FontWeight.w500),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(children: [
                Visibility(
                    visible: !widget.isSocialSign,
                    child: Column(children: [
                      TextFieldRow(
                        icon: Icons.alternate_email_rounded,
                        hintText: "이메일",
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                      ),
                      TextFieldRow(
                        icon: Icons.vpn_key_outlined,
                        hintText: "비밀번호",
                        controller: pwController,
                      ),
                    ])),
                TextFieldRow(
                  icon: Icons.person,
                  hintText: "별명",
                  controller: nameController,
                ),
                Visibility(
                  visible: !widget.isSocialSign,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 40),
                    child: Divider(),
                  ),
                ),
                TextFieldRow(
                  icon: Icons.map_outlined,
                  hintText: "주소",
                  controller: addressController,
                ),
                TextFieldRow(
                  icon: Icons.phone_outlined,
                  hintText: "전화번호",
                  controller: phoneController,
                  inputType: TextInputType.phone,
                ),
              ]),
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
                        onChanged: checkBoxOnChanged,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.3)),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                              width: 1.0, color: Color(0xffB9B9B9)),
                        ),
                        activeColor: WidgetColor.mainColor,
                      ),
                      Text(
                        "이용약관 및 개인정보 처리방침에 동의합니다.",
                        style: TextStyle(
                            fontSize: 16, color: WidgetColor.mainBlack),
                      )
                    ],
                  ),
                ),
                BottomButtonLayout(
                    onTap: completeButtonOnTap,
                    text: "다음",
                    backgroundColor:
                        completeCheck() ? WidgetColor.mainColor : deepGray),
              ],
            )),
          ],
        ),
      ),
    );
  }

  bool completeCheck() {
    bool notSocialSignCheck =
        pwController.text.isNotEmpty && emailController.text.isNotEmpty;
    if (widget.isSocialSign) notSocialSignCheck = true;

    return isCheckToS &&
        notSocialSignCheck &&
        phoneController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
  }

  void checkBoxOnChanged(bool? isCheck) {
    if (isCheck != null) {
      if (!isCheckToS) {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return BottomSheetLayout(onTap: () {
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
  }

  void textFieldOnChanged() {
    if (completeCheck()) {
      setState(() {});
    }
  }

  void controllerListenerSetting({bool isDispose = false}) {
    if (isDispose) {
      if (widget.isSocialSign) {
        emailController.removeListener(textFieldOnChanged);
        pwController.removeListener(textFieldOnChanged);
      }
      phoneController.removeListener(textFieldOnChanged);
      nameController.removeListener(textFieldOnChanged);
      addressController.removeListener(textFieldOnChanged);
    } else {
      if (widget.isSocialSign) {
        emailController.addListener(textFieldOnChanged);
        pwController.addListener(textFieldOnChanged);
      }
      phoneController.addListener(textFieldOnChanged);
      nameController.addListener(textFieldOnChanged);
      addressController.addListener(textFieldOnChanged);
    }
  }

  void completeButtonOnTap() {
    if (!completeCheck()) {
      Utils.util.showSnackBar(context, "입력란 및 이용약관 동의를 확인해주세요.");
    } else {
      if (widget.loginType == 'email') {
        if (!util.isValidEmailFormat(emailController.text)) {
          Utils.util.showSnackBar(context, "이메일 유형을 맞춰주세요.");
          return;
        }

        userProvider.signUpUser(
            context,
            emailController.text,
            pwController.text,
            nameController.text,
            addressController.text,
            phoneController.text);
      } else {
        final user = context.read<UserProvider>().socialUser;
        userProvider.signUpUser(context, user.email, user.mpw,
            nameController.text, addressController.text, phoneController.text);
      }
    }
  }
}
