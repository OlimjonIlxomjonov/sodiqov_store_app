import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavHeight = appH(70) + MediaQuery.of(context).padding.bottom;
    List<String> categoriesList = [
      'Mevalar',
      'Sabzavotlar',
      "Go'sht",
      'Sut',
      'Non',
      'Ichimlik',
    ];

    List<String> stuffList = [
      'Head&Shoulders Shampoo 2in1',
      'Olma qizil (1kg)',
      'Sut 3.2% (1L)',
      'Pomidor (1kg)',
      "Tovuq go'shti (1kg)",
      'Coca Cola 1.5L',
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// {HEADER}
          SliverAppBar(
            backgroundColor: AppColors.white,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: appW(20), right: appW(15)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logo here'),
                  IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppColors.greenFade),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(
                      IconlyLight.notification,
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.white,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: appW(20)),
              title: Container(
                padding: EdgeInsets.symmetric(vertical: appH(2)),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: 'Qidirish...',
                    hintStyle: AppTextStyles.source.regular(
                      fontSize: 14,
                      color: AppColors.greyScale.grey400,
                    ),
                    prefixIcon: Icon(
                      IconlyLight.search,
                      color: AppColors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// {DIVIDER}
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: appH(10)),
              child: Divider(color: AppColors.greyScale.grey300),
            ),
          ),

          /// {CATEGORIES}
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: appW(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kategoriyalar'.toUpperCase(),
                        style: AppTextStyles.source.semiBold(fontSize: 14),
                      ),
                      Icon(IconlyLight.arrow_right, color: AppColors.green),
                    ],
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: appW(10),
                      mainAxisSpacing: appH(10),
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.greyScale.grey300,
                          ),
                        ),
                        child: Column(
                          spacing: appH(20),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconlyLight.close_square),
                            Text(
                              categoriesList[index],
                              style: AppTextStyles.source.regular(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          /// {DIVIDER}
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: appH(10)),
              child: Divider(color: AppColors.greyScale.grey300),
            ),
          ),

          /// {STUFF HEADER}
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: appW(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ommabop mahsulotlar'.toUpperCase(),
                    style: AppTextStyles.source.semiBold(fontSize: 14),
                  ),
                  Icon(IconlyLight.arrow_right, color: AppColors.green),
                ],
              ),
            ),
          ),

          /// {STUFF GRID}
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              appW(10),
              appH(20),
              appW(10),
              bottomNavHeight,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _productCard(index, stuffList),
                childCount: 6,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: appH(10),
                crossAxisSpacing: appW(10),
                childAspectRatio: 0.70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _productCard(int index, List<String> stuffList) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.greyScale.grey300),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppColors.cardBackground,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// {CHEGIRMA}
                      Container(
                        decoration: BoxDecoration(color: AppColors.red),
                        margin: EdgeInsets.only(
                          left: appW(index.isEven ? 10 : 0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: appW(index.isEven ? 5 : 0),
                        ),
                        child: Text(
                          index.isEven ? '-10%' : '',
                          style: AppTextStyles.source.regular(
                            fontSize: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ),

                      /// {HEART}
                      IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.greyScale.grey400,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: AppColors.white,
                        ),
                        onPressed: () {},
                        icon: Icon(IconlyLight.heart),
                      ),
                    ],
                  ),
                  Icon(IconlyLight.close_square),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: appW(10), top: appH(5)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border(
                  top: BorderSide(color: AppColors.greyScale.grey300),
                ),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        IconlyBold.star,
                        size: appH(12),
                        color: AppColors.yellow,
                      ),
                      Text(
                        '4.5',
                        style: AppTextStyles.source.regular(
                          fontSize: 12,
                          color: AppColors.greyScale.grey600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    stuffList[index],
                    style: AppTextStyles.source.medium(fontSize: 14),
                  ),
                  Text(
                    'Sabzavot',
                    style: AppTextStyles.source.regular(fontSize: 12),
                  ),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '108 000 UZS',
                        style: AppTextStyles.source.medium(fontSize: 14),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.greenFade,
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.add, color: AppColors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
