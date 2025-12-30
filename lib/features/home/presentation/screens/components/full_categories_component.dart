import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';

import '../../bloc/category/category_bloc.dart';
import '../../bloc/category/category_state.dart';

class FullCategoriesComponent extends StatelessWidget {
  const FullCategoriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.green),
          onPressed: () => AppRoute.close(),
        ),
        title: Text(
          'Kategoriyalar',
          style: AppTextStyles.source.semiBold(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(appW(20)),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: appH(12),
                  crossAxisSpacing: appW(12),
                  childAspectRatio: 2.8,
                ),
                itemCount: state.entity.length,
                itemBuilder: (context, index) {
                  final category = state.entity[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: appW(14)),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.greyScale.grey300),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          category.name.uz,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.source.medium(
                            fontSize: 14,
                            color: AppColors.greyScale.grey900,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
