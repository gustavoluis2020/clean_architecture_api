import 'package:clean_architecture_api/users/domain/entities/address_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/company_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/geo_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:clean_architecture_api/users/presentation/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('UsersCard displays user information correctly', (WidgetTester tester) async {
    // Arrange
    final user = UsersEntity(
      id: 1,
      name: 'Test User',
      username: 'testuser',
      email: 'testuser@example.com',
      address: AddressEntity(
        street: 'street',
        suite: 'suite',
        city: 'city',
        zipcode: 'zipcode',
        geo: GeoEntity(lat: 'lat', lng: 'lng'),
      ),
      phone: '1234567890',
      website: 'www.testuser.com',
      company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UsersCard(
            user: user,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('testuser@example.com'), findsOneWidget);
  });

  testWidgets('UsersCard calls onPressed when tapped', (WidgetTester tester) async {
    // Arrange
    final user = UsersEntity(
      id: 1,
      name: 'Test User',
      username: 'testuser',
      email: 'testuser@example.com',
      address: AddressEntity(
        street: 'street',
        suite: 'suite',
        city: 'city',
        zipcode: 'zipcode',
        geo: GeoEntity(lat: 'lat', lng: 'lng'),
      ),
      phone: '1234567890',
      website: 'www.testuser.com',
      company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'),
    );

    var wasPressed = false;
    void onPressed() {
      wasPressed = true;
    }

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UsersCard(
            user: user,
            onPressed: onPressed,
          ),
        ),
      ),
    );

    final userCard = find.byType(UsersCard);
    expect(userCard, findsOneWidget);

    final cardFinder = find.byType(Card);
    final gestureDetectorFinder = find.ancestor(
      of: cardFinder,
      matching: find.byType(GestureDetector),
    );

    await tester.tap(gestureDetectorFinder);
    await tester.pump();

    // Assert
    expect(wasPressed, isTrue);
  });
}
