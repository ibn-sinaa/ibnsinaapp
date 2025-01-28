import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ibn_sina/data/repositories/profile_repository.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this._profileRepository) : super(DeleteAccountInitial());

  final ProfileRepository _profileRepository;

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    final result = await _profileRepository.deleteAccount();
    result.fold((failure) {
      emit(DeleteAccountError(failure.message));
    }, (response) {
      emit(DeleteAccountLoaded(response.message));
    });
  }
}
