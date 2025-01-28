import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/data/models/city_model.dart';

import '../../data/repositories/app_repository.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final AppRepository _appRepository;

  CityCubit(this._appRepository) : super(CityInitial());

  getCities() async {
    emit(CityLoading());
    final responseEither = await _appRepository.getCities();

    responseEither.fold(
      (failure) {
        emit(CityError(failure.message));
      },
      (response) {
        emit(CityLoaded(response.data));
      },
    );
  }
}
