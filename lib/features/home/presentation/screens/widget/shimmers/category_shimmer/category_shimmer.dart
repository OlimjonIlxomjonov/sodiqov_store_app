import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../core/commons/constants/colors/app_colors.dart';
import '../../../../../../../core/utils/responsiveness/app_responsiveness.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appH(45),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: appW(20)),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (_, __) => SizedBox(width: appW(10)),
        itemBuilder: (_, __) {
          return Shimmer.fromColors(
            baseColor: AppColors.greyScale.grey200,
            highlightColor: AppColors.greyScale.grey100,
            child: Container(
              width: appW(120),
              padding: EdgeInsets.symmetric(
                horizontal: appW(16),
                vertical: appH(10),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greyScale.grey300),
              ),
            ),
          );
        },
      ),
    );
  }
}
