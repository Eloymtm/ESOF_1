import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/pages/register_page.dart';
import 'package:mockito/mockito.dart';
import 'package:src/pages/map_page.dart';
import 'package:src/pages/login_page.dart'; // Importe o arquivo onde está a classe LoginPage

// Mock para FirebaseAuth para simular o comportamento de signInWithEmailAndPassword
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('Email and Password Fields Render', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      expect(find.byType(TextField), findsNWidgets(2));
    });

    /*testWidgets('Login Button Pressed', (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseAuth?.createUserWithEmailAndPassword(
        email: '123456@gmail.com',
        password: '123456', 
      );

      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
        ),
      );

      await tester.enterText(find.text('Enter your student email...'), '123456@gmail.com');
      await tester.enterText(find.text('Enter your password'), '123456');
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Verifica se signInWithEmailAndPassword foi chamado
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: '123456@gmail.com',
        password: '123456',
      )).called(1);
    });*/

    testWidgets('Create Account Button Pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
          routes: {
            '/register_page': (context) => RegisterPage(), // Mock RegisterPage
          },
        ),
      );

      await tester.tap(find.text('Create account'));
      await tester.pumpAndSettle();

      expect(find.text('Create account'), findsOneWidget); // Verifica se a página de registro está presente
    });
  });
}
