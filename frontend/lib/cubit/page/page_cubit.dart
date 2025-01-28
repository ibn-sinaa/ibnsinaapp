import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/page_model.dart';
import '../../data/repositories/app_repository.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  final AppRepository _appRepository;
  final String? apiToken;

  PageCubit(
    this._appRepository, [
    this.apiToken,
  ]) : super(PageStateInitial());

  getAboutApp() async {
    emit(PageStateLoading());
    final responseEither = await _appRepository.getAboutApp();

    responseEither.fold(
      (failure) {
        emit(PageStateError(failure.message));
      },
      (response) {
        emit(PageStateLoaded(response.data));
      },
    );
  }

  getPolicy() async {
    emit(PageStateLoading());
    final responseEither = await _appRepository.getPolicy();

    responseEither.fold(
      (failure) {
        emit(PageStateError(failure.message));
      },
      (response) {
        emit(PageStateLoaded(response.data));
      },
    );
  }

  getTerms() async {
    emit(PageStateLoading());
    final responseEither = await _appRepository.getTerms(apiToken);

    responseEither.fold(
      (failure) {
        emit(PageStateError(failure.message));
      },
      (response) {
        emit(PageStateLoaded(response.data));
      },
    );
  }
}
