import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../../domain/providers/user_provider.dart';
import '../widget/color.dart';
import '../widget/common_widget.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final UserProvider userProvider = UserProvider();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  void initState() {
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
      appBar: DefaultAppBar(context,
          title: const Text(
            "로그인",
            style: TextStyle(color: mainBlack, fontWeight: FontWeight.w500),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
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
                ],
              ),
            ),
            BottomButton(
              text: "로그인",
              onTap: completeButtonOnTap,
              backgroundColor: completeCheck() ? mainColor : deepGray,
            ),
          ],
        ),
      ),
    );
  }

  bool completeCheck() {
    return pwController.text.isNotEmpty && emailController.text.isNotEmpty;
  }

  void textFieldOnChanged() {
    if (completeCheck()) {
      setState(() {});
    }
  }

  void controllerListenerSetting({bool isDispose = false}) {
    if (isDispose) {
      emailController.removeListener(textFieldOnChanged);
      pwController.removeListener(textFieldOnChanged);
    } else {
      emailController.addListener(textFieldOnChanged);
      pwController.addListener(textFieldOnChanged);
    }
  }

  void completeButtonOnTap() {
    if (!completeCheck()) {
      Utils().showSnackBar(context, "이메일과 비밀번호를 입력해주세요.");
    } else {
      userProvider.loginUser(context, emailController.text, pwController.text);
    }
  }
}
