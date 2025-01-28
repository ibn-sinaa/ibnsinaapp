import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/enums.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ProfileRepository _profileRepository;
  final UserRepository _userRepository;

  UserCubit(
    this._profileRepository,
    this._userRepository,
  ) : super(
          UserState.init(
            _userRepository.getUserData(),
          ),
        );

  void getUserData() {
    final userModel = _userRepository.getUserData();
    emit(state.copyWith(
      userName: userModel.userName,
      image: userModel.image,
    ));
  }

  void updateUserData(UserModel user) {}

  void updateUserName(String userName) {
    emit(state.copyWith(userName: userName));
  }

  void updateImage(String image) {
    emit(state.copyWith(image: image));
  }

  void unauthenticateUser() {
    _profileRepository.unauthenticateUser();
  }

  Future<void> signOut() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final responseEither = await _profileRepository.signOut();
    responseEither.fold(
      (failure) {
        emit(
          state.copyWith(
            requestState: RequestState.error,
            message: failure.message,
          ),
        );
      },
      (response) {
        emit(state.copyWith(
          requestState: RequestState.loaded,
          message: response.message,
        ));
      },
    );
  }
}
