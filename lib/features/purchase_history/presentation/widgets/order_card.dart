import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/commons/constants/colors/app_colors.dart';
import '../../../../core/commons/constants/textstyles/app_text_style.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../domain/entity/local_purchase_history/purchase_history_entity.dart';

class OrderCard extends StatelessWidget {
  final PurchaseHistoryEntity order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(order.purchasedAt);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyScale.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: AppTextStyles.source.medium(fontSize: 13)),
              Text(
                "${order.items.length} ${context.localizations.storage}",
                style: AppTextStyles.source.regular(
                  fontSize: 12,
                  color: AppColors.greyScale.grey600,
                ),
              ),
            ],
          ),

          SizedBox(height: 6),

          /// ITEMS
          Column(
            children: order.items.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name.byLocale(context.locale),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.source.regular(fontSize: 13),
                      ),
                    ),
                    Text(
                      "x${item.quantity}",
                      style: AppTextStyles.source.regular(
                        fontSize: 13,
                        color: AppColors.greyScale.grey600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          Divider(),

          /// TOTAL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localizations.totalCost,
                style: AppTextStyles.source.regular(fontSize: 13),
              ),
              Text(
                "${order.totalPrice.toStringAsFixed(0)} UZS",
                style: AppTextStyles.source.semiBold(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
