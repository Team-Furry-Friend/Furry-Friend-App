import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furry_friend/app/screen/sign_up_screen.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('SignUpScreen Widget Test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({}); // 초기값 설정
    await PrefsUtils.init();


    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
          child: const SignUpScreen(
            isSocialSign: false,
            loginType: 'email',
          ),
        ),
      ),
    );

    // 앱 바의 회원가입 화면 확인
    expect(find.text('회원가입'), findsOneWidget);

    // 데이터 입력
    await tester.enterText(find.byType(TextFieldRow).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFieldRow).at(1), 'password');
    await tester.enterText(find.byType(TextFieldRow).at(2), 'Tester');
    await tester.enterText(find.byType(TextFieldRow).at(3), 'home');
    await tester.enterText(find.byType(TextFieldRow).at(4), '123-456-7890');

    // 입력 확인
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
    expect(find.text('Tester'), findsOneWidget);
    expect(find.text('home'), findsOneWidget);
    expect(find.text('123-456-7890'), findsOneWidget);


    // 이용약관 체크박스 터치
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // 이용약관 확인 버튼 터치
    await tester.tap(find.widgetWithText(BottomButton, '확인').first);
    await tester.pump();


    // 완료 확인
    await tester.tap(find.widgetWithText(BottomButton, '다음').first);
    await tester.pumpAndSettle();
  });
}
