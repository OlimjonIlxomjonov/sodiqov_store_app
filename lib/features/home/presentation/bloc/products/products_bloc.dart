import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/features/home/domain/usecase/products/products_use_case.dart';
import 'package:my_template/features/home/presentation/bloc/home_event.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_state.dart';

class ProductsBloc extends Bloc<HomeEvent, ProductsState> {
  final ProductsUseCase useCase;

  ProductsBloc(this.useCase) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      try {
        if (event.page == 1) {
          emit(ProductsLoading());
          final response = await useCase.call(page: event.page);
          emit(ProductsLoaded(response));
          return;
        }

        if (state is ProductsLoaded) {
          final oldState = state as ProductsLoaded;
          if (event.page > oldState.response.paginationMeta.lastPage) return;

          emit(ProductsLoaded(oldState.response, isLoadingMore: true));

          final response = await useCase.call(page: event.page);

          final updatedData = [...oldState.response.data, ...response.data];
          final updatedResponse = response.copyWith(
            data: updatedData,
            paginationMeta: response.paginationMeta,
          );

          emit(ProductsLoaded(updatedResponse));
        }
      } catch (e) {
        emit(ProductsError());
      }
    });
  }
}
