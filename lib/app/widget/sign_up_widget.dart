import 'package:flutter/material.dart';

import 'color.dart';
import 'common_widget.dart';

class BottomSheetLayout extends StatelessWidget {
  const BottomSheetLayout({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;
  final String noticeText =
      "1. 개인정보의 처리 목적\n① <ㅇㅇㅇ>은(는) 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다."
      "고객 가입의사 확인, 고객에 대한 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 물품 또는 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급·배송, 마케팅 및 광고에의 활용\n"
      "\n2. 개인정보의 처리 및 보유 기간 작성\n"
      "① <ㅇㅇㅇ>은(는) 정보주체로부터 개인정보를 수집할 때 동의 받은 개인정보 보유·이용기간 또는 법령에 따른 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.\n"
      "② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다. 고객 가입 및 관리 : 서비스 이용계약 또는 회원가입 해지시까지, 다만 채권·채무관계 잔존시에는 해당 채권·채무관계 정산시까지 전자상거래에서의 계약·청약철회, 대금결제, 재화 등 공급기록 : 5년\n\n"
      "3. 정보주체와 법정대리인의 권리·의무 및 그 행사방법 "
      "개인정보 처리업무: 홈페이지 회원가입 및 관리, 민원사무 처리, 재화 또는 서비스 제공, 마케팅 및 광고에의 활용 \n "
      "필수항목: 로그인ID, 비밀번호, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 선택항목: 이메일, 성별, 이름";

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter bottomState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              '이용약관',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Text(noticeText),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: BottomButton(
                onTap: () => onTap(), text: "확인", backgroundColor: mainBlack),
          )
        ],
      );
    });
  }
}
