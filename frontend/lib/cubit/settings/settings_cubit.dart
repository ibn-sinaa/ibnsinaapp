import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/settings_model.dart';
import '../../data/repositories/app_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AppRepository _appRepository;

  SettingsCubit(this._appRepository) : super(SettingsInitial());

  Future<(SettingsModel?, String)> getAppSettings() async {
    emit(SettingsLoading());
    final responseEither = await _appRepository.getAppSettings();

    return responseEither.fold(
      (failure) {
        emit(SettingsError(failure.message));
        return (null, failure.message);
      },
      (response) {
        emit(SettingsLoaded(response.data));
        return (response.data, '');
      },
    );
  }
}
