import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/features/cart/domain/usecase/order/order_use_case.dart';
import 'package:my_template/features/cart/presentation/bloc/cart_event.dart';
import 'package:my_template/features/cart/presentation/bloc/order/order_state.dart';

class OrderBloc extends Bloc<CartEvent, OrderState> {
  final OrderUseCase useCase;

  OrderBloc(this.useCase) : super(OrderInitial()) {
    on<SendOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await useCase.call(
          phone: event.phone,
          shippingAddress: event.shippingAddress,
        );
        emit(OrderLoaded());
      } catch (e) {
        emit(OrderError());
      }
    });
  }
}
