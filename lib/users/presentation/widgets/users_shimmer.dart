import 'package:clean_architecture_api/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UsersListShimmer extends StatelessWidget {
  const UsersListShimmer({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        index,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Card(
            color: AppColors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Shimmer.fromColors(
                      baseColor: AppColors.baseColor!,
                      highlightColor: AppColors.background!,
                      child: Container(
                        height: 20,
                        width: 250,
                        decoration: BoxDecoration(
                          color: AppColors.baseColor!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: AppColors.baseColor!,
                      highlightColor: AppColors.background!,
                      child: Container(
                        height: 10,
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppColors.baseColor!,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
