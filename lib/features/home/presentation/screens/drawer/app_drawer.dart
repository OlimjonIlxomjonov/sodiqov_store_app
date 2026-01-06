import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/commons/assets/app_vectors.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/extensions/context_extension.dart';
import 'package:my_template/core/l10n/l10n.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/services/language_storage/language_storage.dart';
import 'package:my_template/core/streams/general_stram.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/favourites/presentation/screens/favourites_page.dart';
import 'package:my_template/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/category/category_state.dart';
import 'package:my_template/features/purchase_history/presentation/screens/purchase_history_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
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
          Card(
            shadowColor: AppColors.greyScale.grey200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Column(
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.green,
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    );
                  } else if (state is CategoryLoaded) {
                    final item = state.entity;
                    return ExpansionTile(
                      backgroundColor: AppColors.greenFade,
                      collapsedBackgroundColor: AppColors.white,
                      title: Text(context.localizations.kategories),
                      leading: Icon(
                        IconlyLight.category,
                        color: AppColors.green,
                      ),
                      children: item.map((e) {
                        int index = item.indexOf(e);
                        return ListTile(
                          onTap: () {
                            AppRoute.close();
                          },
                          contentPadding: EdgeInsets.only(left: appW(10)),
                          leading: Text('#${index + 1}'),
                          title: Text(e.name.byLocale(context.locale)),
                        );
                      }).toList(),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
          Card(
            shadowColor: AppColors.greyScale.grey200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                backgroundColor: AppColors.greenFade,
                collapsedBackgroundColor: AppColors.white,
                title: Text(
                  currentLocale.languageCode == 'uz'
                      ? "O'zbek Tili"
                      : "Русский язык",
                ),
                leading: Icon(Icons.language, color: AppColors.blue),
                children: [
                  ListTile(
                    title: Text("O'zbek Tili"),
                    onTap: () async {
                      const locale = Locale('uz');
                      await LanguageStorage.save(locale);
                      GeneralStream.languageStream.add(locale);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("Русский язык"),
                    onTap: () async {
                      const locale = Locale('ru');
                      await LanguageStorage.save(locale);
                      GeneralStream.languageStream.add(locale);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(IconlyBold.heart, color: AppColors.red),
            title: Text(context.localizations.favourites),
            onTap: () {
              Navigator.pop(context);
              AppRoute.go(FavouritesPage());
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.box, color: AppColors.deepOrange),
            title: Text(context.localizations.purchaseHistory),
            onTap: () {
              Navigator.pop(context);
              AppRoute.go(PurchaseHistoryPage());
            },
          ),

          // Divider(color: AppColors.greyScale.grey300),
          // ListTile(
          //   iconColor: AppColors.red,
          //   leading: Icon(IconlyLight.logout),
          //   title: Text(
          //     'LogOut',
          //     style: AppTextStyles.source.regular(
          //       fontSize: 15,
          //       color: AppColors.red,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
