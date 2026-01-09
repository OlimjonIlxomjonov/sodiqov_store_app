import 'package:flutter/material.dart';

import '../../../../core/commons/constants/colors/app_colors.dart';
import '../../../../core/commons/constants/textstyles/app_text_style.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/routes/route_generator.dart';
import '../../../../core/services/purchase_history_storage/purchase_hisotry_storage.dart';
import '../../domain/entity/local_purchase_history/purchase_history_entity.dart';
import '../widgets/order_card.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// {HEADER}
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
              },
            ),
            title: Text(
              context.localizations.purchaseHistory,
              style: AppTextStyles.source.semiBold(fontSize: 16),
            ),
          ),

          SliverToBoxAdapter(
            child: FutureBuilder<List<PurchaseHistoryEntity>>(
              future: PurchaseHistoryStorage.getHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Icon(
                          Icons.history,
                          size: 48,
                          color: AppColors.greyScale.grey400,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Empty',
                          style: AppTextStyles.source.medium(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                final history = snapshot.data!;

                return Column(
                  children: history.map((order) {
                    return OrderCard(order: order);
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
