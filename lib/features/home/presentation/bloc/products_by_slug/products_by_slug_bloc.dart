import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/features/home/domain/usecase/products_by_slug/products_by_slug_use_case.dart';
import 'package:my_template/features/home/presentation/bloc/home_event.dart';
import 'package:my_template/features/home/presentation/bloc/products_by_slug/products_by_slug_state.dart';

class ProductsBySlugBloc extends Bloc<HomeEvent, ProductsBySlugState> {
  final ProductsBySlugUseCase useCase;

  ProductsBySlugBloc(this.useCase) : super(ProductsBySlugInitial()) {
    on<ProductsBySlugEvent>((event, emit) async {
      emit(ProductsBySlugLoading());
      try {
        final entity = await useCase.call(slug: event.slug);
        emit(ProductsBySlugLoaded(entity));
      } catch (e) {
        emit(ProductsBySlugError());
      }
    });
  }
}
