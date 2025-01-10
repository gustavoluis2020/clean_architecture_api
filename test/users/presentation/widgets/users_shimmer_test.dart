import 'package:clean_architecture_api/users/presentation/widgets/users_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('UsersListShimmer displays shimmer effect correctly', (WidgetTester tester) async {
    // Arrange
    const int shimmerCount = 5;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UsersListShimmer(index: shimmerCount),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(find.byType(Card), findsNWidgets(shimmerCount));
  });
}
