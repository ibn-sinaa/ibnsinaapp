import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/category/category_model.dart';
import '../../data/repositories/products_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductsRepository _productsRepository;
  final int? id;

  CategoryCubit(
    this._productsRepository, [
    this.id,
  ]) : super(CategoryInitial());

  getCategories() async {
    emit(CategoryLoading());
    final responseEither = await _productsRepository.getCategories(id);

    responseEither.fold(
      (failure) => emit(CategoryError(failure.message)),
      (response) => emit(CategoryLoaded(response.data)),
    );
  }

  resetState() {
    emit(CategoryInitial());
  }
}
