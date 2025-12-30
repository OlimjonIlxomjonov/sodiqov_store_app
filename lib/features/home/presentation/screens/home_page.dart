import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:my_template/core/commons/assets/app_vectors.dart';
import 'package:my_template/core/commons/constants/api_urls/api_urls.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/cart/presentation/screens/cart_page.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_state.dart';
import 'package:my_template/features/home/presentation/screens/components/full_categories_component.dart';
import 'package:my_template/features/home/presentation/screens/components/full_products_component.dart';
import 'package:my_template/features/home/presentation/screens/drawer/app_drawer.dart';

import '../bloc/category/category_bloc.dart';
import '../bloc/category/category_state.dart';
import '../bloc/home_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _priceFormatter = NumberFormat('#,##0', 'en_US');

  String formatPrice(num price) {
    return _priceFormatter.format(price);
  }

  int discountPercent(int? oldPrice, int newPrice) {
    if (oldPrice == null || oldPrice == 0) return 0;
    return (((oldPrice - newPrice) / oldPrice) * 100).round();
  }

  String buildImageUrl(String path) {
    if (path.startsWith('http')) return path;
    return 'https://sodiqovstore.uz/storage/$path';
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryEvent());
    context.read<ProductsBloc>().add(ProductsEvent(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<CategoryBloc>().add(CategoryEvent());
            context.read<ProductsBloc>().add(ProductsEvent(1));
          },
          child: CustomScrollView(
            slivers: [
              /// {HEADER}
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.white,
                pinned: false,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: appW(20),
                    right: appW(15),
                  ),
                  title: Row(
                    children: [
                      SvgPicture.asset(
                        AppVectors.appLogo,
                        width: appW(50),
                        color: AppColors.green,
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: AppColors.greenFade),
                          ),
                        ),
                        onPressed: () {
                          AppRoute.go(CartPage());
                        },
                        icon: Icon(IconlyLight.bag_2, color: AppColors.green),
                      ),
                      Builder(
                        builder: (context) {
                          return IconButton(
                            style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: AppColors.greenFade),
                              ),
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: Icon(Icons.menu, color: AppColors.green),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
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

              /// {CATEGORIES }
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: appH(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: appW(20)),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            AppRoute.go(FullCategoriesComponent());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kategoriyalar'.toUpperCase(),
                                style: AppTextStyles.source.semiBold(
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                IconlyLight.arrow_right,
                                color: AppColors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: appH(12)),

                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryLoaded) {
                            return SizedBox(
                              height: appH(45),
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(
                                  horizontal: appW(20),
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: appW(10)),
                                itemBuilder: (context, index) {
                                  final category = state.entity[index];
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: appW(16),
                                        vertical: appH(10),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.cardBackground,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.greyScale.grey300,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          category.name.uz,
                                          style: AppTextStyles.source.medium(
                                            fontSize: 14,
                                            color: AppColors.greyScale.grey900,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is CategoryLoading) {
                            return LinearProgressIndicator(
                              color: AppColors.green,
                            );
                          }
                          return SizedBox.shrink();
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
                  child: GestureDetector(
                    onTap: () {
                      /// FULL PRODUCTS PAGE
                      AppRoute.go(FullProductsComponent());
                    },
                    behavior: HitTestBehavior.opaque,
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
              ),

              /// {STUFF GRID}
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoaded) {
                    final products = state.response.data;

                    return SliverPadding(
                      padding: EdgeInsets.only(bottom: appH(20), top: appH(15)),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: appH(10),
                          crossAxisSpacing: appW(10),
                          childAspectRatio: 0.50,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _productCard(products[index]),
                          childCount: products.length,
                        ),
                      ),
                    );
                  } else if (state is ProductsLoading) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productCard(ProductsEntity item) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.greyScale.grey200,
            offset: Offset(0, 4),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                image: item.images.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(buildImageUrl(item.images.first)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// {DISCOUNT BADGE}
                      if (item.oldPrice != null && item.oldPrice! > item.price)
                        Container(
                          decoration: BoxDecoration(color: AppColors.red),
                          margin: EdgeInsets.only(left: appW(10)),
                          padding: EdgeInsets.symmetric(horizontal: appW(5)),
                          child: Text(
                            '-${discountPercent(item.oldPrice?.toInt(), item.price.toInt())}%',
                            style: AppTextStyles.source.regular(
                              fontSize: 12,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                      /// {HEART BUTTON}
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: appW(10),
                top: appH(5),
                bottom: appH(2),
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.greyScale.grey300),
                ),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name.uz,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.source.medium(fontSize: 14),
                  ),
                  Text(
                    item.category.name.uz,
                    style: AppTextStyles.source.regular(fontSize: 12),
                  ),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.oldPrice != null &&
                              item.oldPrice! > item.price)
                            Text(
                              "${formatPrice(item.oldPrice!)} so'm",
                              style: TextStyle(
                                fontSize: AppResponsiveness.heigh(12),
                                color: AppColors.greyScale.grey600,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            "${formatPrice(item.price)} so'm",
                            style: AppTextStyles.source.medium(fontSize: 14),
                          ),
                        ],
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
