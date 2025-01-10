import 'package:clean_architecture_api/core/constants/app_colors.dart';
import 'package:clean_architecture_api/core/constants/app_texts.dart';
import 'package:clean_architecture_api/core/routes/app_pages.dart';
import 'package:clean_architecture_api/users/controller/users_controller.dart';
import 'package:clean_architecture_api/users/presentation/widgets/users_card.dart';
import 'package:clean_architecture_api/users/presentation/widgets/users_shimmer.dart';
import 'package:clean_architecture_api/users/presentation/widgets/users_warning.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends GetView<UsersController> {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(AppTexts.usersList),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 4,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const UsersListShimmer(index: 5);
          }

          if (controller.errorMessage.isNotEmpty) {
            return UsersWarning(
              onPressed: () {
                controller.getUsers();
              },
            );
          }

          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return UsersCard(
                user: user,
                onPressed: () {
                  Get.toNamed(AppRoutes.userDetail, arguments: user);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
