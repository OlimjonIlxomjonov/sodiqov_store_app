import 'package:flutter/material.dart';

import '../../../../core/commons/constants/textstyles/app_text_style.dart';

class AnimatedText extends StatelessWidget {
  final String text;
  final AnimationController controller;

  const AnimatedText({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(text.length, (index) {
        final animation = CurvedAnimation(
          parent: controller,
          curve: Interval(
            index / text.length,
            (index + 1) / text.length,
            curve: Curves.bounceInOut,
          ),
        );

        return ScaleTransition(
          scale: animation,
          child: Text(
            text[index],
            style: AppTextStyles.source.medium(fontSize: 25),
          ),
        );
      }),
    );
  }
}
