import 'package:clean_architecture_api/user_details/binding/user_details_binding.dart';
import 'package:clean_architecture_api/user_details/presentation/user_details_page.dart';
import 'package:clean_architecture_api/users/binding/users_binding.dart';
import 'package:clean_architecture_api/users/presentation/users_page.dart';
import 'package:clean_architecture_api/core/routes/app_pages.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.users,
      page: () => const UsersPage(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: AppRoutes.userDetail,
      page: () => const UserDetailsPage(),
      binding: UserDetailsBinding(),
    ),
  ];
}
