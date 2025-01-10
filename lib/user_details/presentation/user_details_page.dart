import 'package:clean_architecture_api/core/constants/app_colors.dart';
import 'package:clean_architecture_api/core/constants/app_texts.dart';
import 'package:clean_architecture_api/user_details/controller/user_details_controller.dart';
import 'package:clean_architecture_api/user_details/presentation/widgets/user_details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsPage extends GetView<UserDetailsController> {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(AppTexts.userDetails),
        centerTitle: true,
        elevation: 4,
      ),
      body: UserDetailsCard(user: controller.user),
    );
  }
}
