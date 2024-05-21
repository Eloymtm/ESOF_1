import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/pages/register_page.dart';
import 'package:mockito/mockito.dart';
import 'package:src/pages/map_page.dart';
import 'package:src/pages/login_page.dart';



void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('Email and Password Fields Render', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('Create Account Button Pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LoginPage(),
          routes: {
            '/register_page': (context) => const RegisterPage(), // Mock RegisterPage
          },
        ),
      );

       expect(find.text('Criar conta'), findsOneWidget);

    final createAccountButton = find.text('Criar conta');
    expect(createAccountButton, findsOneWidget);

    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();


    expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
