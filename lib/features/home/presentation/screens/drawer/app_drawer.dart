import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/commons/assets/app_vectors.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: AppColors.greenFade),
            child: SvgPicture.asset(
              AppVectors.appLogo,
              width: appW(100),
              fit: BoxFit.contain,
              color: AppColors.green,
            ),
          ),
          ListTile(
            leading: Icon(IconlyLight.category, color: AppColors.green),
            title: Text('Kategoriyalar'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.language, color: AppColors.blue),
            title: Text("O'zbek Tili"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(IconlyBold.heart, color: AppColors.red),
            title: Text("Favourites"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: AppColors.greyScale.grey300),
          ListTile(
            iconColor: AppColors.red,
            leading: Icon(IconlyLight.logout),
            title: Text(
              'LogOut',
              style: AppTextStyles.source.regular(
                fontSize: 15,
                color: AppColors.red,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
