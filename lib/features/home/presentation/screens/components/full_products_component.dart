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
import 'package:my_template/features/home/presentation/screens/widget/product_card.dart';

import '../../bloc/home_event.dart';

class FullProductsComponent extends StatefulWidget {
  const FullProductsComponent({super.key});

  @override
  State<FullProductsComponent> createState() => _FullProductsComponentState();
}

class _FullProductsComponentState extends State<FullProductsComponent> {
  final scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;

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
                          mainAxisSpacing: appH(15),
                          crossAxisSpacing: appW(10),
                          childAspectRatio: 0.50,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (index < products.length) {
                            return ProductCard(
                              item: products[index],
                              enableHero: false,
                            );
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
}
