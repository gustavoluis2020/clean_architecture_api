import 'package:clean_architecture_api/user_details/controller/user_details_controller.dart';
import 'package:get/get.dart';

class UserDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailsController>(() => UserDetailsController());
  }
}
