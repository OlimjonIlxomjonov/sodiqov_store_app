import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/commons/constants/colors/app_colors.dart';
import '../../../../../../../core/utils/responsiveness/app_responsiveness.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.greyScale.grey200,
      highlightColor: AppColors.greyScale.grey100,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.greyScale.grey200,
              offset: const Offset(0, 4),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            /// IMAGE AREA
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Container(color: AppColors.greyScale.grey300),

                    /// discount badge placeholder
                    Positioned(
                      top: appH(8),
                      left: appW(8),
                      child: Container(
                        width: appW(30),
                        height: appH(14),
                        color: AppColors.greyScale.grey400,
                      ),
                    ),

                    /// heart placeholder
                    Positioned(
                      top: appH(6),
                      right: appW(6),
                      child: Container(
                        width: appW(28),
                        height: appW(28),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// INFO AREA
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: appW(10),
                  top: appH(6),
                  right: appW(8),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.greyScale.grey300),
                  ),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// title
                    Container(
                      height: appH(12),
                      width: double.infinity,
                      color: AppColors.greyScale.grey300,
                    ),
                    SizedBox(height: appH(6)),

                    /// category
                    Container(
                      height: appH(10),
                      width: appW(80),
                      color: AppColors.greyScale.grey300,
                    ),

                    const Spacer(),

                    /// price + add button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: appH(10),
                              width: appW(60),
                              color: AppColors.greyScale.grey300,
                            ),
                            SizedBox(height: appH(4)),
                            Container(
                              height: appH(12),
                              width: appW(70),
                              color: AppColors.greyScale.grey400,
                            ),
                          ],
                        ),

                        Container(
                          width: appW(34),
                          height: appW(34),
                          decoration: BoxDecoration(
                            color: AppColors.greyScale.grey400,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
