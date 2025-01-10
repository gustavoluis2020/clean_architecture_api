import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:clean_architecture_api/users/domain/use_cases/get_users_use_case.dart';
import 'package:clean_architecture_api/core/helpers/failures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  RxList<UsersEntity> users = <UsersEntity>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    isLoading.value = true;
    errorMessage.value = '';
    GetUsersUseCase getUsers = Get.find();
    final result = await getUsers(NoParams());
    result.fold((l) {
      debugPrint(l.toString());
      errorMessage.value = l.message ?? 'Ocorreu um Erro Inesperado';
      isLoading.value = false;
    }, (r) {
      users.value = r;
      isLoading.value = false;
    });
  }
}
