import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.green),
              onPressed: () => AppRoute.close(),
            ),
            title: Text(
              'Savatcha',
              style: AppTextStyles.source.semiBold(fontSize: 16),
            ),
            centerTitle: true,
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: appH(10)),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyScale.grey200),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: appW(15),
                    vertical: appH(15),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: appW(15),
                    vertical: appH(10),
                  ),

                  child: Row(
                    spacing: appW(10),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          border: Border.all(
                            color: AppColors.greyScale.grey400,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: appW(20),
                          vertical: appH(20),
                        ),
                        child: Icon(IconlyLight.close_square),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Head&Shoulders",
                            style: AppTextStyles.source.medium(fontSize: 14),
                          ),
                          Text(
                            "Soch yuvish",
                            style: AppTextStyles.source.regular(
                              fontSize: 12,
                              color: AppColors.greyScale.grey600,
                            ),
                          ),
                          SizedBox(height: appH(10)),
                          Text(
                            '120 000 UZS',
                            style: AppTextStyles.source.semiBold(fontSize: 15),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: appH(20),
                        children: [
                          Icon(IconlyLight.delete, color: AppColors.red),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: appW(8),
                              vertical: appH(5),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.greyScale.grey300,
                              ),
                            ),
                            child: Row(
                              spacing: appW(20),
                              children: [
                                addOrRemoveContainer(Icons.remove),
                                Text('1'),
                                addOrRemoveContainer(Icons.add),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }, childCount: 10),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: appW(10),
            vertical: appH(10),
          ),
          child: Column(
            spacing: appH(10),
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'JAMI SUMMA',
                    style: AppTextStyles.source.regular(
                      fontSize: 16,
                      color: AppColors.greyScale.grey600,
                    ),
                  ),
                  Text(
                    '190 000 UZS',
                    style: AppTextStyles.source.medium(fontSize: 18),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, appH(45)),
                ),
                onPressed: () {},
                child: Text(
                  'Buyurtma berish',
                  style: AppTextStyles.source.regular(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container addOrRemoveContainer(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.greyScale.grey600),
    );
  }
}
