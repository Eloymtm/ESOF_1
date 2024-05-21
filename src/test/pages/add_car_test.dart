import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:src/pages/profile/add_car_page.dart';

void main() {
  testWidgets('AddCarPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AddCarPage(),
      ),
    );

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Adicionar Carro'), findsOneWidget);


    expect(find.widgetWithText(TextFormField, 'Marca'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Modelo'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Ano'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Capacidade'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Cor'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Matrícula'), findsOneWidget);

    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
  
  });

}
