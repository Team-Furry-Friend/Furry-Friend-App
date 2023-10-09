import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furry_friend/app/screen/login_email_screen.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('LoginEmailScreen Widget Test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({}); // 초기값 설정
    await PrefsUtils.init();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
          child: const LoginEmailScreen(),
        ),
      ),
    );

    // 로그인 버튼 확인
    expect(find.byType(BottomButton), findsOneWidget);

    // 각 필드에 데이터 입력
    await tester.enterText(
        find.byKey(const Key('idTextField')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('pwTextField')), 'password');

    // 입력 확인
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);

    // 로그인 버튼 탭
    await tester.tap(find.byType(BottomButton));

    // 완료 대기
    await tester.pumpAndSettle();
  });
}
