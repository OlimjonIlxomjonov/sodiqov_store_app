import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/features/home/domain/usecase/category/category_use_case.dart';
import 'package:my_template/features/home/presentation/bloc/category/category_state.dart';
import 'package:my_template/features/home/presentation/bloc/home_event.dart';

class CategoryBloc extends Bloc<HomeEvent, CategoryState> {
  final CategoryUseCase useCase;

  CategoryBloc(this.useCase) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final entity = await useCase.call();
        emit(CategoryLoaded(entity));
      } catch (e) {
        emit(CategoryError());
      }
    });
  }
}
