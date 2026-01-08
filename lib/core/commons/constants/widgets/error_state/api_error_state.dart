import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/extensions/context_extension.dart';

import '../../../../utils/responsiveness/app_responsiveness.dart';
import '../../colors/app_colors.dart';
import '../../textstyles/app_text_style.dart';

class ApiErrorState extends StatelessWidget {
  final VoidCallback onTap;

  const ApiErrorState({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(appH(18)),
            decoration: BoxDecoration(
              color: AppColors.greenFade,
              shape: BoxShape.circle,
            ),
            child: Icon(
              IconlyLight.danger,
              size: appH(42),
              color: AppColors.green,
            ),
          ),

          SizedBox(height: appH(16)),
          Text(
            context.localizations.somethingWentWrong,
            textAlign: TextAlign.center,
            style: AppTextStyles.source.semiBold(fontSize: 18),
          ),
          SizedBox(height: appH(8)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appH(32)),
            child: Text(
              context.localizations.checkInternetConnectionAndTryAgain,
              textAlign: TextAlign.center,
              style: AppTextStyles.source.regular(
                fontSize: 14,
                color: AppColors.greyScale.grey600,
              ),
            ),
          ),

          SizedBox(height: appH(20)),

          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: appH(24),
                vertical: appH(10),
              ),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(appH(12)),
              ),
              child: Text(
                context.localizations.tryAgain,
                style: AppTextStyles.source.semiBold(
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
