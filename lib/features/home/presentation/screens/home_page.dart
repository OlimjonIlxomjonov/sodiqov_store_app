import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/commons/assets/app_vectors.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/commons/constants/widgets/error_state/api_error_state.dart';
import 'package:my_template/core/extensions/context_extension.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/cart/presentation/screens/cart_page.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_state.dart';
import 'package:my_template/features/home/presentation/screens/components/full_categories_component.dart';
import 'package:my_template/features/home/presentation/screens/components/full_products_component.dart';
import 'package:my_template/features/home/presentation/screens/drawer/app_drawer.dart';
import 'package:my_template/features/home/presentation/screens/widget/product_card.dart';
import 'package:my_template/features/home/presentation/screens/widget/shimmers/category_shimmer/category_shimmer.dart';
import 'package:my_template/features/home/presentation/screens/widget/shimmers/product_shimmer/products_grid_shimmer.dart';

import '../../../../core/services/cart_storage/cart_storage.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/category/category_state.dart';
import '../bloc/home_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCartCount();
    context.read<CategoryBloc>().add(CategoryEvent());
    context.read<ProductsBloc>().add(ProductsEvent(1));
  }

  Future<void> _loadCartCount() async {
    final items = await CartStorage.getCartWithQuantity();
    setState(() {
      cartCount = items.fold<int>(
        0,
        (sum, item) => sum + (item['quantity'] as int),
      );
    });
  }

  void refreshCartCount() async {
    final items = await CartStorage.getCartWithQuantity();
    setState(() {
      cartCount = items.fold<int>(
        0,
        (sum, item) => sum + (item['quantity'] as int),
      );
    });
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
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: AppColors.greenFade),
                              ),
                            ),
                            onPressed: () async {
                              AppRoute.go(
                                CartPage(onCartChanged: refreshCartCount),
                              );
                              _loadCartCount();
                            },
                            icon: Icon(
                              IconlyLight.bag_2,
                              color: AppColors.green,
                            ),
                          ),
                          if (cartCount > 0)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Center(
                                  child: Text(
                                    '$cartCount',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
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
                        hintText: context.localizations.search,
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
                                context.localizations.kategories.toUpperCase(),
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
                                          category.name.byLocale(
                                            context.locale,
                                          ),
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
                            return CategoryShimmer();
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
                          context.localizations.popularProducts.toUpperCase(),
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
                          (context, index) {
                            if (index < products.length) {
                              return ProductCard(
                                item: products[index],
                                enableHero: true,
                                onAddToCart: () {
                                  refreshCartCount();
                                },
                              );
                            } else if (state.isLoadingMore) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.green,
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                          childCount:
                              products.length + (state.isLoadingMore ? 1 : 0),
                        ),
                      ),
                    );
                  } else if (state is ProductsLoading) {
                    return ProductsGridShimmer();
                  } else if (state is ProductsError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: ApiErrorState(
                        onTap: () {
                          context.read<ProductsBloc>().add(ProductsEvent(1));
                          context.read<CategoryBloc>().add(CategoryEvent());
                        },
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
}
