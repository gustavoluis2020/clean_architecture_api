import 'package:clean_architecture_api/users/presentation/widgets/users_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('UsersWarning displays warning message correctly', (WidgetTester tester) async {
    // Arrange
    const warningMessage =
        'Parece que houve um problema ao carregar os dados. Por favor, tente novamente em alguns minutos.';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UsersWarning(
            onPressed: () {},
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(find.text(warningMessage), findsOneWidget);
  });
}
