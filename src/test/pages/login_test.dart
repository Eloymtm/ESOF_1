import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/lib/pages/login_page.dart'; 

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  testWidgets('Login screen has expected text', (WidgetTester tester) async {
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: auth)));

    expect(find.text("UNILIFT"), findsOneWidget);
    expect(find.text('Enter your student email...'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });

  testWidgets('Login button triggers sign-in function', (WidgetTester tester) async {
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: auth)));

    // Inserindo texto nos campos de e-mail e senha
    await tester.enterText(find.byType(TextEditingController).first, 'amotemartim@gmail.com');
    await tester.enterText(find.byType(TextEditingController).last, '123456'); 

    // Clicando no botão de login
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verificando se a função signIn foi chamada com os valores corretos
    verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'amotemartim@gmail.com', password: '123456')).called(1);
  });

  testWidgets('Create account button triggers onTap function', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(MaterialApp(home: LoginPage(auth : auth)));

    // Clicando no botão de criar conta
    await tester.tap(find.text('Create account'));
    await tester.pump();

    // Verificando se a função onTap foi chamada
    expect(tapped, true);
  });
}
