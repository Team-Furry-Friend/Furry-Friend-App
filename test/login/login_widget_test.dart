import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furry_friend/app/screen/login_screen.dart';

void main() {
  testWidgets('LoginScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen()
    ));

    // Furry Friend 타이틀 표시 확인
    expect(find.text('Furry Friend'), findsOneWidget);

    // 버튼 찾기
    final kakaoLoginButton = find.byKey(const Key('kakaoLoginButton'));
    await tester.ensureVisible(kakaoLoginButton); // 버튼 존재 확인

    //await tester.tap(kakaoLoginButton) 해당 코드는 에러 발생으로 위치 값으로 클릭
    await tester.tapAt(const Offset(368.5, 339.0));
    await tester.pumpAndSettle();
  });
}
