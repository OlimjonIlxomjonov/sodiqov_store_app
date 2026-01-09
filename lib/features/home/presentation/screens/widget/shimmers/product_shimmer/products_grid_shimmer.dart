import 'package:flutter/material.dart';
import 'package:my_template/features/home/presentation/screens/widget/shimmers/product_shimmer/product_shimmer.dart';

import '../../../../../../../core/utils/responsiveness/app_responsiveness.dart';

class ProductsGridShimmer extends StatelessWidget {
  const ProductsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: appH(15), bottom: appH(20)),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: appH(10),
          crossAxisSpacing: appW(10),
          childAspectRatio: 0.65,
        ),
        delegate: SliverChildBuilderDelegate(
          (_, __) => const ProductCardShimmer(),
          childCount: 6,
        ),
      ),
    );
  }
}
