import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavHeight = appH(80) + MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appH(5),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(color: AppColors.greyScale.grey300),
            SizedBox(height: appH(10)),

            /// {USER CARD}
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: appW(15),
                vertical: appH(10),
              ),
              decoration: BoxDecoration(
                color: AppColors.greenFade,
                border: Border.all(color: AppColors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: appW(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// {USER}
                  Row(
                    spacing: appW(10),
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: appH(20),
                          vertical: appH(15),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'U',
                          style: AppTextStyles.source.bold(
                            fontSize: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Foydalanuvchi',
                            style: AppTextStyles.source.medium(fontSize: 15),
                          ),
                          Text(
                            'user@example.com',
                            style: AppTextStyles.source.regular(
                              fontSize: 13,
                              color: AppColors.greyScale.grey600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: appH(10)),

                  /// {USER DATA}
                  Divider(color: AppColors.greyScale.grey300),
                  SizedBox(height: appH(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      userInfo('24', 'BUYURTMA'),
                      userInfo('12', 'SEVIMLI'),
                      userInfo('340K', 'XARID'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: appH(20)),

            /// {SETTINGS}
            settingsCard(
              () {},
              'Mening Profilim',
              "Shaxsiy ma'lumotlarni tahrirlash",
              IconlyLight.profile,
            ),
            settingsCard(
              () {},
              'Buyurtmalarim',
              "Buyurtmalarim tarixi",
              IconlyLight.bookmark,
            ),
            settingsCard(
              () {},
              'Yatkazish manzillari',
              "2 ta saqlangan manzil",
              IconlyLight.location,
            ),
            settingsCard(
              () {},
              "To'lov kartalari",
              "Kartalarni boshqarish",
              Icons.credit_card,
            ),
            settingsCard(
              () {},
              "Sevimlilar",
              "12 ta mahsulot",
              IconlyLight.heart,
            ),
            settingsCard(
              () {},
              "Yordam markazi",
              "24/7 onlayn qo'llab-quvvatlash",
              Icons.phone,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: appW(20),
                right: appW(20),
                top: appH(15),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, appH(45)),
                  backgroundColor: AppColors.greenFade,
                  foregroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: appW(10),
                  children: [
                    Icon(IconlyLight.logout, color: AppColors.green),
                    Text(
                      'Hisobdan chiqish',
                      style: AppTextStyles.source.medium(
                        fontSize: 14,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: bottomNavHeight),
          ],
        ),
      ),
    );
  }

  GestureDetector settingsCard(
    VoidCallback onTap,
    String title,
    String subTitle,
    IconData icon,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: appW(20), vertical: appH(10)),
        padding: EdgeInsets.symmetric(horizontal: appW(10), vertical: appH(5)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyScale.grey300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            padding: EdgeInsets.symmetric(
              horizontal: appW(15),
              vertical: appH(10),
            ),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              border: Border.all(color: AppColors.greyScale.grey300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.source.medium(fontSize: 14)),
              Text(
                subTitle,
                style: AppTextStyles.source.regular(
                  fontSize: 12,
                  color: AppColors.greyScale.grey600,
                ),
              ),
            ],
          ),
          trailing: Icon(
            IconlyLight.arrow_right_2,
            size: appH(20),
            color: AppColors.greyScale.grey600,
          ),
        ),
      ),
    );
  }

  Column userInfo(String statOne, String statTwo) => Column(
    children: [
      Text(statOne, style: AppTextStyles.source.medium(fontSize: 16)),
      Text(
        statTwo,
        style: AppTextStyles.source.regular(
          fontSize: 12,
          color: AppColors.greyScale.grey600,
        ),
      ),
    ],
  );
}
