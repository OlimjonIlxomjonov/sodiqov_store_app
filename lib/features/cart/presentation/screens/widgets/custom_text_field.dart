import 'package:flutter/material.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: .circular(4)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: appH(5)),
        child: SizedBox(
          height: appH(100),
          child: TextField(
            controller: controller,
            maxLines: null,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.source.regular(
                fontSize: 13,
                color: AppColors.greyScale.grey600,
              ),
              prefixIcon: Icon(icon),
            ),
          ),
        ),
      ),
    );
  }
}
