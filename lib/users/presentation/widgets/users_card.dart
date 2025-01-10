import 'package:clean_architecture_api/core/constants/app_colors.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:flutter/material.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({super.key, required this.user, required this.onPressed});

  final UsersEntity user;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Card(
          color: AppColors.background,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            title: Text(user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text(user.email),
          ),
        ),
      ),
    );
  }
}
