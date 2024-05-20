import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:src/pages/register_page.dart';


import '../widget_test.dart';

void main() {
  group('RegisterPage', () {
    late RegisterPage widget;

    setUp(() {
      widget = const RegisterPage();
    });

    testWidgets('Check if all text fields are present', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(widget));

      expect(find.byKey(const Key("emailField")), findsOneWidget);
      expect(find.byKey(const Key("nameField")), findsOneWidget);
      expect(find.byKey(const Key("passwordField")), findsOneWidget);
      expect(find.byKey(const Key("confirmPasswordField")), findsOneWidget);
    });
  });
}