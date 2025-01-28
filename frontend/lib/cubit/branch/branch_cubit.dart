import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/branch_model.dart';
import '../../data/repositories/app_repository.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final AppRepository _appRepository;

  BranchCubit(this._appRepository) : super(BranchInitial());

  getBranches() async {
    emit(BranchLoading());
    final responseEither = await _appRepository.getBranches();

    responseEither.fold(
      (failure) {
        emit(BranchError(failure.message));
      },
      (response) {
        emit(BranchLoaded(response.data));
      },
    );
  }
}
