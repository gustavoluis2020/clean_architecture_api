import 'package:clean_architecture_api/core/constants/app_colors.dart';
import 'package:clean_architecture_api/core/constants/app_texts.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:flutter/material.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({super.key, required this.user});

  final UsersEntity user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        color: AppColors.background,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppTexts.userDetailsName} ${user.name}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsNickName} ${user.username}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsEmail}: ${user.email}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsSite} ${user.website}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsPhone} ${user.phone}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsAddress} ${user.address.street}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${user.address.suite}  -  ${AppTexts.userDetailsZipCode} ${user.address.zipcode}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsCity} ${user.address.city}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsLatitude} ${user.address.geo.lat}  -  ${AppTexts.userDetailsLongitude} ${user.address.geo.lng}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsCompany} ${user.company.name}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsProduct} ${user.company.catchPhrase}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppTexts.userDetailsAbout} ${user.company.bs}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
