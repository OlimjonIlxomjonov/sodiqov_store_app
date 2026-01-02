import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/home_event.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_bloc.dart';
import '../../../../core/commons/constants/colors/app_colors.dart';
import '../../../../core/commons/constants/textstyles/app_text_style.dart';
import '../../../../core/routes/route_generator.dart';
import '../../../../core/services/liked_product_storage/liked_product_storage.dart';
import '../../../home/domain/entity/products/products_entity.dart';
import '../../../home/presentation/screens/widget/product_card.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<ProductsEntity> _favorites = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _favorites = await FavoritesStorage.getFavorites();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              floating: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.green),
                onPressed: () {
                  context.read<ProductsBloc>().add(ProductsEvent(1));
                  AppRoute.close();
                },
              ),
              title: Text(
                'Sevimlilar',
                style: AppTextStyles.source.semiBold(fontSize: 16),
              ),
            ),

            if (_loading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_favorites.isEmpty)
              const SliverFillRemaining(
                child: Center(child: Text('Sevimlilar yo‘q')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.50,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(item: _favorites[index]);
                  }, childCount: _favorites.length),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
