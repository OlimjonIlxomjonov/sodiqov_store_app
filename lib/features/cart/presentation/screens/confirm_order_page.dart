import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/commons/constants/widgets/flush_bar/error_flushbar.dart';
import 'package:my_template/core/commons/constants/widgets/flush_bar/success_flushbar.dart';
import 'package:my_template/core/extensions/context_extension.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/logger/logger.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/cart/presentation/bloc/cart_event.dart';
import 'package:my_template/features/cart/presentation/bloc/order/order_bloc.dart';
import 'package:my_template/features/cart/presentation/bloc/order/order_state.dart';
import 'package:my_template/features/cart/presentation/screens/widgets/custom_text_field.dart';
import 'package:my_template/features/home/presentation/screens/home_page.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/cart_storage/cart_storage.dart';
import '../../../../core/services/purchase_history_storage/purchase_hisotry_storage.dart';
import '../../../home/domain/entity/products/products_entity.dart';
import '../../../purchase_history/domain/entity/local_purchase_history/purchase_history_entity.dart';
import '../../../purchase_history/domain/entity/local_purchase_history/purchase_item_entity.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({super.key});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  List<ProductsEntity> cartItems = [];
  final _priceFormatter = NumberFormat('#,##0', 'en_US');
  int productAmount = 1;
  Map<String, int> productAmounts = {};
  PhoneNumber number = PhoneNumber(isoCode: 'UZ');
  final addressController = TextEditingController();
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final itemsWithQty = await CartStorage.getCartWithQuantity();

    setState(() {
      cartItems = itemsWithQty
          .map((e) => e['product'] as ProductsEntity)
          .toList();
      productAmounts = {
        for (var e in itemsWithQty)
          (e['product'] as ProductsEntity).id.toString(): e['quantity'] as int,
      };
    });
  }

  double get totalPrice {
    double total = 0;

    for (final item in cartItems) {
      final quantity = productAmounts[item.id.toString()] ?? 1;
      total += item.price * quantity;
    }

    return total;
  }

  String formatPrice(num price) {
    return _priceFormatter.format(price);
  }

  /// {SEND ORDER}
  void sendOrder() {
    final phone = phoneNumber?.trim() ?? '';
    final address = addressController.text.trim();

    if (phone.isEmpty || address.isEmpty) {
      errorFlushBar(context, context.localizations.enterPhoneAndAddress);
      return;
    }

    logger.f(phone);
    logger.f(address);

    context.read<OrderBloc>().add(SendOrderEvent(phone, address));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(context.localizations.orderProduct),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: appW(10),
                  vertical: appH(5),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: appW(15),
                  vertical: appH(10),
                ),
                decoration: BoxDecoration(
                  color: AppColors.warningBack,
                  borderRadius: .circular(10),
                  border: Border.all(color: AppColors.warningIconColor),
                ),
                child: Row(
                  spacing: appW(10),
                  children: [
                    CircleAvatar(
                      radius: appH(25),
                      backgroundColor: AppColors.deepOrange.withValues(
                        alpha: .1,
                      ),
                      child: Icon(IconlyLight.buy, color: AppColors.darkBlue),
                    ),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          context.localizations.payment,
                          style: AppTextStyles.source.medium(fontSize: 15),
                        ),
                        Text(
                          context.localizations.withCash,
                          style: AppTextStyles.source.regular(
                            fontSize: 13,
                            color: AppColors.greyScale.grey900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// {TELEFON RAQAM}
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: appW(15),
                vertical: appH(10),
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  spacing: appH(5),
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      context.localizations.enterPhoneNumber,
                      style: AppTextStyles.source.medium(
                        fontSize: 13,
                        color: AppColors.greyScale.grey600,
                      ),
                    ),
                    Card(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: appH(5)),
                        child: InternationalPhoneNumberInput(
                          selectorTextStyle: AppTextStyles.source.medium(
                            fontSize: 14,
                          ),
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                            setSelectorButtonAsPrefixIcon: true,
                            leadingPadding: 20,
                            trailingSpace: false,
                          ),
                          hintText: context.localizations.phoneNumber,
                          initialValue: number,
                          inputBorder: InputBorder.none,
                          onInputChanged: (value) {
                            phoneNumber = value.phoneNumber;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: appW(15)),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: appH(5),
                  children: [
                    SizedBox(height: appH(20)),
                    Text(
                      context.localizations.deliveryAddress,
                      style: AppTextStyles.source.medium(
                        fontSize: 13,
                        color: AppColors.greyScale.grey600,
                      ),
                    ),
                    CustomTextField(
                      controller: addressController,
                      hintText: context.localizations.address,
                      icon: IconlyLight.location,
                    ),
                  ],
                ),
              ),
            ),

            /// {ITEMS THAT USER GONNA BUY}
            SliverPadding(
              padding: EdgeInsets.only(bottom: appH(5), top: appH(20)),
              sliver: SliverToBoxAdapter(
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      '${context.localizations.yourOrders} — ${cartItems.length}${context.localizations.storage}',
                    ),
                    children: List.generate(cartItems.length, (index) {
                      final item = cartItems[index];
                      final quantity = productAmounts[item.id.toString()] ?? 1;

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.greyScale.grey200,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: appW(15),
                          vertical: appH(5),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: appW(15),
                          vertical: appH(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: appW(60),
                              height: appH(75),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(10),
                                image: item.images.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          'https://sodiqovstore.uz/storage/${item.images.first}',
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                            SizedBox(width: appW(10)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.name.byLocale(context.locale),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.source.medium(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "X$quantity",
                                    style: AppTextStyles.source.regular(
                                      fontSize: 12,
                                      color: AppColors.greyScale.grey600,
                                    ),
                                  ),
                                  SizedBox(height: appH(5)),
                                  Text(
                                    '${formatPrice(item.price * quantity)} UZS',
                                    style: AppTextStyles.source.semiBold(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: appW(15)),
          child: Column(
            spacing: appH(10),
            mainAxisSize: .min,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    context.localizations.totalCost,
                    style: AppTextStyles.source.regular(
                      fontSize: 14,
                      color: AppColors.greyScale.grey600,
                    ),
                  ),
                  Text(
                    "${formatPrice(totalPrice)} UZS",
                    style: AppTextStyles.source.medium(fontSize: 15),
                  ),
                ],
              ),
              BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) async {
                  if (state is OrderLoaded) {
                    final itemsWithQty =
                        await CartStorage.getCartWithQuantity();

                    final purchase = PurchaseHistoryEntity(
                      id: const Uuid().v4(),
                      purchasedAt: DateTime.now(),
                      phone: phoneNumber!,
                      address: addressController.text,
                      totalPrice: totalPrice,
                      items: itemsWithQty.map((e) {
                        return PurchaseItemEntity(
                          product: e['product'],
                          quantity: e['quantity'],
                        );
                      }).toList(),
                    );

                    await PurchaseHistoryStorage.addPurchase(purchase);
                    await CartStorage.clearCart();
                    await _loadCart();

                    successFlushBar(context, context.localizations.success);
                    AppRoute.open(HomePage());
                  } else if (state is OrderError) {
                    errorFlushBar(
                      context,
                      context.localizations.errorOccurredTryLater,
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is OrderLoading;

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, appH(45)),
                    ),
                    onPressed: sendOrder,
                    child: isLoading
                        ? CircularProgressIndicator(color: AppColors.greenFade)
                        : Text(context.localizations.orderProduct),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
