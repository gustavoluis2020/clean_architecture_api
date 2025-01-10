import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController {
  late final UsersEntity user;

  @override
  void onInit() {
    super.onInit();
    user = Get.arguments as UsersEntity;
  }
}
