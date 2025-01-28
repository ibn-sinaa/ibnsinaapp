import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/data/models/career_model.dart';

import '../../data/repositories/app_repository.dart';

part 'career_level_state.dart';

class CareerLevelCubit extends Cubit<CareerLevelState> {
  final AppRepository _appRepository;

  CareerLevelCubit(this._appRepository) : super(CareerLevelInitial());

  getCareerLevels([String? apiToken]) async {
    emit(CareerLevelLoading());
    final responseEither = await _appRepository.getCareerLevels(apiToken);

    responseEither.fold(
      (failure) {
        emit(CareerLevelError(failure.message));
      },
      (response) {
        emit(CareerLevelLoaded(response.data));
      },
    );
  }
}
