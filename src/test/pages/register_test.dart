import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:src/pages/login_page.dart';
import 'package:src/pages/register_page.dart';


import '../widget_test.dart';

void main() {
  group('RegisterPage', () {
    late RegisterPage widget;

    setUp(() {
      widget = RegisterPage();
    });

    testWidgets('Check if all text fields are present', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterPage()));

      expect(find.byKey(const Key("emailField")), findsOneWidget);
      expect(find.byKey(const Key("nameField")), findsOneWidget);
      expect(find.byKey(const Key("passwordField")), findsOneWidget);
      expect(find.byKey(const Key("confirmPasswordField")), findsOneWidget);
    });

    testWidgets('Already have an account button navigates to Login Page', (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(
          home: RegisterPage(),
          routes: {
            '/login_page': (context) => LoginPage(),
          },
        ),
      );

      await tester.tap(find.text('Já tem conta?'));
      await tester.pumpAndSettle();
      

      expect(find.text('UNILIFT'), findsOneWidget);
    });
  });
}
