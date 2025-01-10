import 'package:clean_architecture_api/core/constants/app_colors.dart';
import 'package:clean_architecture_api/core/constants/app_texts.dart';
import 'package:clean_architecture_api/core/routes/app_pages.dart';
import 'package:clean_architecture_api/users/controller/users_controller.dart';
import 'package:clean_architecture_api/users/domain/entities/address_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/company_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/geo_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:clean_architecture_api/users/presentation/users_page.dart';
import 'package:clean_architecture_api/users/presentation/widgets/users_card.dart';
import 'package:clean_architecture_api/users/presentation/widgets/users_shimmer.dart';
import 'package:clean_architecture_api/users/presentation/widgets/users_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class FakeRoute extends Fake implements Route<dynamic> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockUsersController extends Mock implements UsersController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback<void>(callback: () {});
}

void main() {
  Get.testMode = true;
  late MockUsersController mockController;
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockController = MockUsersController();
    Get.put<UsersController>(mockController);

    mockObserver = MockNavigatorObserver();
    registerFallbackValue(FakeRoute());
  });

  Widget makeTestableWidget(Widget child) {
    return GetMaterialApp(
      navigatorObservers: [mockObserver],
      home: child,
      getPages: [
        GetPage(name: '/users', page: () => const Placeholder()),
        GetPage(name: '/userDetails', page: () => const Placeholder()),
      ],
    );
  }

  tearDown(() {
    Get.reset();
  });

  group('UsersPage Widget Tests', () {
    testWidgets('Should display UsersListShimmer when loading', (WidgetTester tester) async {
      when(() => mockController.isLoading).thenReturn(true.obs);
      when(() => mockController.errorMessage).thenReturn(''.obs);
      when(() => mockController.users).thenReturn(<UsersEntity>[].obs);

      await tester.pumpWidget(makeTestableWidget(const UsersPage()));
      await tester.pump();

      expect(find.byType(UsersListShimmer), findsOneWidget);
    });

    testWidgets('Should display UsersWarning when error occurs', (WidgetTester tester) async {
      when(() => mockController.isLoading).thenReturn(false.obs);
      when(() => mockController.errorMessage).thenReturn('Error fetching users'.obs);
      when(() => mockController.users).thenReturn(<UsersEntity>[].obs);

      await tester.pumpWidget(makeTestableWidget(const UsersPage()));
      await tester.pump();

      expect(find.byType(UsersWarning), findsOneWidget);
      expect(find.text(AppTexts.usersWarning), findsOneWidget);
    });

    testWidgets('Should display UsersCard list when data is loaded', (WidgetTester tester) async {
      final users = [
        UsersEntity(
          id: 1,
          name: 'Leanne Graham',
          email: 'john.doe@example.com',
          username: '',
          address: AddressEntity(
            street: 'street',
            suite: 'suite',
            city: 'city',
            zipcode: 'zipcode',
            geo: GeoEntity(lat: 'lat', lng: 'lng'),
          ),
          phone: '',
          website: '',
          company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'),
        ),
        UsersEntity(
          id: 2,
          name: 'Ervin Howell',
          email: 'john.doe@example.com',
          username: '',
          address: AddressEntity(
              street: 'street',
              suite: 'suite',
              city: 'city',
              zipcode: 'zipcode',
              geo: GeoEntity(lat: 'lat', lng: 'lng')),
          phone: '',
          website: '',
          company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'),
        )
      ];

      when(() => mockController.isLoading).thenReturn(false.obs);
      when(() => mockController.errorMessage).thenReturn(''.obs);
      when(() => mockController.users).thenReturn(users.obs);

      await tester.pumpWidget(makeTestableWidget(const UsersPage()));
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(UsersCard), findsNWidgets(users.length));

      expect(find.text('Leanne Graham'), findsOneWidget);
      expect(find.text('Ervin Howell'), findsOneWidget);
    });

    testWidgets('Should navigate to user detail when UsersCard is tapped', (WidgetTester tester) async {
      final users = [
        UsersEntity(
          id: 1,
          name: 'Leanne Graham',
          email: 'john.doe@example.com',
          username: '',
          address: AddressEntity(
            street: 'street',
            suite: 'suite',
            city: 'city',
            zipcode: 'zipcode',
            geo: GeoEntity(lat: 'lat', lng: 'lng'),
          ),
          phone: '',
          website: '',
          company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'),
        ),
        UsersEntity(
            id: 2,
            name: 'Ervin Howell',
            email: 'john.doe@example.com',
            username: '',
            address: AddressEntity(
                street: 'street',
                suite: 'suite',
                city: 'city',
                zipcode: 'zipcode',
                geo: GeoEntity(lat: 'lat', lng: 'lng')),
            phone: '',
            website: '',
            company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'))
      ];

      when(() => mockController.isLoading).thenReturn(false.obs);
      when(() => mockController.errorMessage).thenReturn(''.obs);
      when(() => mockController.users).thenReturn(users.obs);

      await tester.pumpWidget(makeTestableWidget(const UsersPage()));
      await tester.pump();

      final userCardFinder = find.widgetWithText(UsersCard, 'Leanne Graham');
      expect(userCardFinder, findsOneWidget, reason: 'UsersCard with text "Leanne Graham" not found');

      await tester.tap(userCardFinder);

      await tester.pump(const Duration(milliseconds: 1000));

      expect(Get.currentRoute, AppRoutes.userDetail);
    });

    testWidgets('Should have correct AppBar properties', (WidgetTester tester) async {
      when(() => mockController.isLoading).thenReturn(false.obs);
      when(() => mockController.errorMessage).thenReturn(''.obs);
      when(() => mockController.users).thenReturn(<UsersEntity>[].obs);

      await tester.pumpWidget(makeTestableWidget(const UsersPage()));
      await tester.pump();

      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final appBar = tester.widget<AppBar>(appBarFinder);
      expect((appBar.title as Text).data, AppTexts.usersList);
      expect(appBar.centerTitle, true);
      expect(appBar.backgroundColor, AppColors.background);
      expect(appBar.elevation, 4);
    });
  });
}













// class MockUsersController extends Mock implements UsersController {
//   @override
//   InternalFinalCallback<void> get onStart => InternalFinalCallback<void>(callback: () {});
//   final _isLoading = false.obs;
//   final _errorMessage = ''.obs;
//   final _users = <UsersEntity>[].obs;

//   @override
//   RxBool get isLoading => _isLoading;

//   @override
//   RxString get errorMessage => _errorMessage;

//   @override
//   RxList<UsersEntity> get users => _users;

//   void setLoading(bool value) {
//     _isLoading.value = value;
//   }

//   void setErrorMessage(String value) {
//     _errorMessage.value = value;
//   }

//   void setUsers(List<UsersEntity> value) {
//     _users.value = value;
//   }

//   @override
//   Future<List<UsersEntity>> getUsers() async {
//     return [
//       UsersEntity(
//           id: 1,
//           name: 'Leanne Graham"',
//           email: 'john.doe@example.com',
//           username: '',
//           address: AddressEntity(
//               street: 'street',
//               suite: 'suite',
//               city: 'city',
//               zipcode: 'zipcode',
//               geo: GeoEntity(lat: 'lat', lng: 'lng')),
//           phone: '',
//           website: '',
//           company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs')),
//     ];
//   }
// }

// void main() {
//   late MockUsersController mockController;

//   setUp(() {
//     mockController = MockUsersController();
//     Get.put<UsersController>(mockController);
//   });

//   tearDown(() {
//     Get.reset();
//   });

//   testWidgets('Exibe UsersListShimmer enquanto carrega', (tester) async {
//     // Mock do estado inicial
//     mockController.setLoading(true);
//     mockController.setErrorMessage('');
//     mockController.setUsers([]);

//     // Montar o widget
//     await tester.pumpWidget(
//       const GetMaterialApp(
//         home: UsersPage(),
//       ),
//     );

//     // Verificar se o shimmer é exibido
//     expect(find.byType(UsersListShimmer), findsOneWidget);
//     expect(find.byType(UsersWarning), findsNothing);
//     expect(find.byType(UsersCard), findsNothing);
//   });

//   testWidgets('Exibe UsersWarning em caso de erro', (tester) async {
//     // Mock do estado com erro
//     mockController.setLoading(false);
//     mockController.setErrorMessage('Erro ao carregar usuários');
//     mockController.setUsers([]);

//     // Montar o widget
//     await tester.pumpWidget(
//       const GetMaterialApp(
//         home: UsersPage(),
//       ),
//     );

//     // Verificar se o aviso de erro é exibido
//     expect(find.byType(UsersWarning), findsOneWidget);
//     expect(find.byType(UsersListShimmer), findsNothing);
//     expect(find.byType(UsersCard), findsNothing);

//     // Simular clique no botão "Tentar novamente"
//     final retryButton = find.text(AppTexts.tryAgain);
//     await tester.tap(retryButton);
//     await tester.pump();

//     // Verificar se o método getUsers foi chamado
//     verify(() => mockController.getUsers()).called(1);
//   });

//   testWidgets('Exibe lista de UsersCard quando há dados disponíveis', (tester) async {
//     // Mock do estado com usuários
//     mockController.setLoading(false);
//     mockController.setErrorMessage('');
//     mockController.setUsers([
//       UsersEntity(
//           id: 1,
//           name: 'Leanne Graham"',
//           email: 'john.doe@example.com',
//           username: '',
//           address: AddressEntity(
//               street: 'street',
//               suite: 'suite',
//               city: 'city',
//               zipcode: 'zipcode',
//               geo: GeoEntity(lat: 'lat', lng: 'lng')),
//           phone: '',
//           website: '',
//           company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs')),
//     ]);

//     // Montar o widget
//     await tester.pumpWidget(
//       const GetMaterialApp(
//         home: UsersPage(),
//       ),
//     );

//     // Verificar se os cards são exibidos
//     expect(find.byType(UsersCard), findsOneWidget);
//     expect(find.text('Leanne Graham"'), findsOneWidget);
//   });

//   testWidgets('Navega para a página de detalhes ao tocar no UsersCard', (tester) async {
//     final user = UsersEntity(
//         id: 1,
//         name: 'Leanne Graham"',
//         email: 'john.doe@example.com',
//         username: '',
//         address: AddressEntity(
//             street: 'street', suite: 'suite', city: 'city', zipcode: 'zipcode', geo: GeoEntity(lat: 'lat', lng: 'lng')),
//         phone: '',
//         website: '',
//         company: CompanyEntity(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'));

//     // Mock do estado com um usuário
//     mockController.setLoading(false);
//     mockController.setErrorMessage('');
//     mockController.setUsers([user]);

//     // Montar o widget com rotas definidas
//     await tester.pumpWidget(
//       GetMaterialApp(
//         initialRoute: '/',
//         getPages: [
//           GetPage(name: '/', page: () => const UsersPage()),
//           GetPage(name: '/userDetails', page: () => const Placeholder()), // Substituir pelo widget de detalhe
//         ],
//       ),
//     );

//     // Simular clique no UsersCard
//     final userCard = find.text('Leanne Graham"');
//     await tester.tap(userCard);
//     await tester.pumpAndSettle();

//     // Verificar se a navegação aconteceu
//     expect(Get.currentRoute, '/userDetails');
//     expect(Get.arguments, user);
//   });
// }




