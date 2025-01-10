import 'package:clean_architecture_api/core/constants/app_texts.dart';
import 'package:clean_architecture_api/user_details/controller/user_details_controller.dart';
import 'package:clean_architecture_api/user_details/presentation/user_details_page.dart';
import 'package:clean_architecture_api/user_details/presentation/widgets/user_details_card.dart';
import 'package:clean_architecture_api/users/domain/entities/address_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/company_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/geo_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockUserDetailsController extends Mock implements UserDetailsController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback<void>(callback: () {});
}

void main() {
  Get.testMode = true;
  late MockUserDetailsController mockController;

  setUp(() {
    mockController = MockUserDetailsController();
    Get.put<UserDetailsController>(mockController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('UserDetailsPage displays user details correctly', (WidgetTester tester) async {
    // Arrange
    final user = UsersEntity(
      id: 1,
      name: 'Leanne Graham',
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

    when(() => mockController.user).thenReturn(user);

    // Act
    await tester.pumpWidget(
      const GetMaterialApp(
        home: UserDetailsPage(),
      ),
    );

    // Assert
    expect(find.text(AppTexts.userDetails), findsOneWidget);
    expect(find.byType(UserDetailsCard), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
