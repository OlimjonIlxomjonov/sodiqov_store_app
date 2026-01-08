import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';
import '../../textstyles/app_text_style.dart';

void errorFlushBar(BuildContext context, String message) {
  Flushbar(
    messageText: Text(
      message,
      style: AppTextStyles.source.semiBold(
        color: AppColors.white,
        fontSize: 16,
      ),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    icon: Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.close, color: AppColors.red),
    ),
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
    borderRadius: BorderRadius.circular(5),
  ).show(context);
}
