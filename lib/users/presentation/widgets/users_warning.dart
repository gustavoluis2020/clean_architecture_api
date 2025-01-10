import 'package:clean_architecture_api/core/constants/app_colors.dart';
import 'package:clean_architecture_api/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class UsersWarning extends StatelessWidget {
  const UsersWarning({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_rounded, color: AppColors.red, size: 80),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppTexts.usersWarning,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.background,
              side: BorderSide(
                color: AppColors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              AppTexts.tryAgain,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
