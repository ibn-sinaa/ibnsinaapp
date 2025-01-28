import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/data/models/career_model.dart';

import '../../core/utils/enums.dart';
import '../../data/params/update_profile_params.dart';
import '../../data/repositories/profile_repository.dart';
import '../user/user_cubit.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  final ProfileRepository _profileRepository;
  final UserCubit userCubit;

  MyProfileCubit(
    this._profileRepository,
    this.userCubit,
  ) : super(MyProfileState.init());

  getMyProfile() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final responseEither = await _profileRepository.getMyProfile();
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        emit(
          state.copyWith(
            requestState: RequestState.loaded,
            image: response.data.image,
            userName: response.data.userName,
            email: response.data.email,
            educationalLevel: EducationalLevel.values.firstWhere(
                (level) => level.key == response.data.educationLevel),
            universityName: response.data.universityName,
            careerLevel: response.data.careerLevel,
            inReview: response.data.inReview,
          ),
        );
        if (userCubit.state.userName != response.data.userName) {
          userCubit.updateUserName(response.data.userName);
        }
        if (userCubit.state.image != response.data.image) {
          userCubit.updateImage(response.data.image);
        }
      },
    );
  }

  userNameChanged(String userName) {
    emit(state.copyWith(
      userName: userName,
      updateState: RequestState.none,
    ));
  }

  emailChanged(String email) {
    emit(state.copyWith(
      email: email,
      updateState: RequestState.none,
    ));
  }

  imageChanged(String image) {
    emit(state.copyWith(
      image: image,
      updateState: RequestState.none,
    ));
  }

  void educationalLevelChanged(EducationalLevel educationalLevel) {
    emit(state.copyWith(
      educationalLevel: educationalLevel,
      updateState: RequestState.none,
    ));
  }

  void universityNameChanged(String universityName) {
    print(universityName);
    emit(state.copyWith(
      universityName: universityName,
      updateState: RequestState.none,
    ));
  }

  void careerLevelChanged(CareerModel careerLevel) {
    emit(state.copyWith(
      careerLevel: careerLevel,
      updateState: RequestState.none,
    ));
  }

  enableUpdate() {
    emit(state.copyWith(
      showError: true,
      enableUpdating: true,
      updateState: RequestState.none,
    ));
  }

  saveNewInfo(GlobalKey<FormState> formState) async {
    if (formState.currentState!.validate()) {
      emit(state.copyWith(
        updateState: RequestState.loading,
      ));
      print(state.universityName);
      final responseEither = await _profileRepository.updateMyProfile(
        UpdateProfileParams(
          userName: state.userName,
          email: state.email,
          educationLevel: state.educationalLevel!.key,
          careerLevelId: state.careerLevel!.id,
          universityName: state.universityName,
        ),
      );
      responseEither.fold(
        (failure) {
          emit(state.copyWith(
            updateState: RequestState.error,
            message: failure.message,
          ));
        },
        (response) {
          userCubit.updateUserName(state.userName);
          emit(state.copyWith(
            updateState: RequestState.loaded,
            message: response.message,
            enableUpdating: false,
          ));
        },
      );
    }
  }

  Future<bool> saveProfileImage(File file) async {
    emit(state.copyWith(
      updateState: RequestState.loading,
    ));
    final responseEither = await _profileRepository.updateMyProfileImage(
      file,
    );
    return responseEither.fold(
      (failure) {
        emit(state.copyWith(
          updateState: RequestState.error,
          message: failure.message,
        ));
        return false;
      },
      (response) {
        emit(state.copyWith(
          updateState: RequestState.loaded,
          message: response.message,
        ));
        return true;
      },
    );
  }
}
