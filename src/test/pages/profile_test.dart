import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:src/pages/profile/edit_profile_page.dart';
import 'package:src/pages/profile/profile_page.dart';
import 'package:src/pages/profile/profile_widget.dart';
import 'package:flutter/cupertino.dart';


import 'package:firebase_auth/firebase_auth.dart';


// Mock para FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  group('profile_widget Tests', () {
    testWidgets('Icon Definitions', (WidgetTester tester) async {
      // Define a chave global para o Scaffold para facilitar o teste de navegação

      // Build profile_widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: profile_widget(
              title: "Definições",
              icon: Icons.settings,
              onPress: () {

              },
            ),
          ),
        ),
      );

      // Verifique se o título está correto
      expect(find.text("Definições"), findsOneWidget);

      // Verifique se o ícone está correto
      expect(find.byIcon(Icons.settings), findsOneWidget);

      // Toque no widget e verifique se o onPress é chamado
      await tester.tap(find.byType(profile_widget));
      await tester.pump(); // Rebuild the widget

    });

testWidgets('profile_widget renders with correct title and icon for "Meus carros"', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: profile_widget(
              title: "Meus carros",
              icon: CupertinoIcons.car,
              onPress: () {
              },
            ),
          ),
        ),
      );

      expect(find.text("Meus carros"), findsOneWidget);

      expect(find.byIcon(CupertinoIcons.car), findsOneWidget);

      await tester.tap(find.byType(profile_widget));
      await tester.pump();
    });

    testWidgets('profile_widget renders with correct title and icon for "Minhas viagens"', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: profile_widget(
              title: "Minhas viagens",
              icon: CupertinoIcons.location_solid,
              onPress: () {
              },
            ),
          ),
        ),
      );

      expect(find.text("Minhas viagens"), findsOneWidget);

      expect(find.byIcon(CupertinoIcons.location_solid), findsOneWidget);

      await tester.tap(find.byType(profile_widget));
      await tester.pump();
    });

    testWidgets('profile_widget renders with correct title and icon for "Histórico"', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: profile_widget(
              title: "Histórico",
              icon: Icons.history,
              onPress: () {
              },
            ),
          ),
        ),
      );

      expect(find.text("Histórico"), findsOneWidget);

      expect(find.byIcon(Icons.history), findsOneWidget);

      await tester.tap(find.byType(profile_widget));
      await tester.pump();
    });
  });
}


