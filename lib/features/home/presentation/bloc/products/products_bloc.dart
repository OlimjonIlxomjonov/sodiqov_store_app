import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/features/home/domain/usecase/products/products_use_case.dart';
import 'package:my_template/features/home/presentation/bloc/home_event.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_state.dart';

class ProductsBloc extends Bloc<HomeEvent, ProductsState> {
  final ProductsUseCase useCase;

  ProductsBloc(this.useCase) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      // emit(ProductsLoading());
      try {
        final response = await useCase.call(page: event.page);
        if (event.page > 1 && state is ProductsLoaded) {
          final oldState = state as ProductsLoaded;

          if (event.page > oldState.response.paginationMeta.lastPage) return;

          final updatedData = [...oldState.response.data, ...response.data];
          final updatedResponse = response.copyWith(
            data: updatedData,
            paginationMeta: response.paginationMeta,
          );
          emit(ProductsLoaded(updatedResponse));
        } else {
          emit(ProductsLoaded(response));
        }
      } catch (e) {
        emit(ProductsError());
      }
    });
  }
}
