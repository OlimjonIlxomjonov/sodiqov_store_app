import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_state.dart';

import '../../bloc/home_event.dart';

class FullProductsComponent extends StatefulWidget {
  const FullProductsComponent({super.key});

  @override
  State<FullProductsComponent> createState() => _FullProductsComponentState();
}

class _FullProductsComponentState extends State<FullProductsComponent> {
  final _priceFormatter = NumberFormat('#,##0', 'en_US');
  final scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;

  String formatPrice(num price) => _priceFormatter.format(price);

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
    page = 1;
    context.read<ProductsBloc>().add(ProductsEvent(page));
    scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    final state = context.read<ProductsBloc>().state;
    if (state is! ProductsLoaded) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 1000) {
      if (page >= state.response.paginationMeta.lastPage) return;

      setState(() {
        isLoading = true;
      });

      page++;
      context.read<ProductsBloc>().add(ProductsEvent(page));

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductsBloc>().add(ProductsEvent(page));
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                backgroundColor: AppColors.white,
                centerTitle: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.green),
                  onPressed: () {
                    AppRoute.close();
                    context.read<ProductsBloc>().add(ProductsEvent(1));
                  },
                ),
                title: Text(
                  'Barcha mahsulotlar',
                  style: AppTextStyles.source.semiBold(fontSize: 16),
                ),
              ),

              /// Products Grid
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoaded) {
                    final products = state.response.data;

                    if (products.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Text(
                              "Mahsulot topilmadi",
                              style: AppTextStyles.source.medium(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: EdgeInsets.only(bottom: appH(20), top: appH(15)),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: appH(10),
                          crossAxisSpacing: appW(10),
                          childAspectRatio: 0.50,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (index < products.length) {
                            return _productCard(products[index]);
                          } else {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: CircularProgressIndicator(
                                  color: AppColors.green,
                                ),
                              ),
                            );
                          }
                        }, childCount: products.length + (isLoading ? 1 : 0)),
                      ),
                    );
                  } else if (state is ProductsLoading) {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.green,
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingIndicator() {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(color: AppColors.green),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.greyScale.grey400),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: AppColors.white,
                    ),
                    onPressed: () {},
                    icon: Icon(IconlyLight.heart),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                    ],
                  ),
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
