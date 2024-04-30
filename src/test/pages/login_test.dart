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
      late FirebaseAuth realFirebaseAuth;

    setUp(() {
      // Inicializando a instância do FirebaseAuth
      realFirebaseAuth = FirebaseAuth.instance;
    });

    test('Sign in with email and password', () async {
      // Configurando a instância do FirebaseAuth para retornar um usuário autenticado
      FirebaseAuth.instance = MockFirebaseAuth();

      // Chamando o método de autenticação
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'test@example.com', password: 'password123');

      // Verificando se o resultado é o esperado
      expect(result.user!.email, 'test@example.com');
    });
    });
*/
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
