import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/failures/app_failure.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/data/models/intro_model.dart';
import 'package:ibn_sina/data/repositories/app_repository.dart';
import 'package:ibn_sina/data/repositories/user_repository.dart';
import '../../config/config.dart';
import '../../config/locale/language_manager.dart';
import '../../core/api/status_code.dart';
import '../../core/services/service_locator.dart';
import '../../core/utils/app_strings.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppRepository _appRepository;
  final UserRepository _userRepository;

  SplashCubit(
    this._appRepository,
    this._userRepository,
  ) : super(SplashStateInit());

  goToNextRoute(BuildContext context) async {
    _setFirebaseTokenToConfig(context).then(
      (either) => either.fold(
        (failure) {
          emit(SplashStateError(failure.message));
        },
        (_) async {
          final isGuest = _userRepository.isGuest();
          locator<SharedData>().isGuest = isGuest;
          if (_userRepository.isFirstTime()) {
            emit(SplashStateLoading());
            final responseEither = await _appRepository.getIntroData();
            responseEither.fold(
              (failure) {
                emit(SplashStateError(failure.message));
              },
              (response) {
                emit(SplashStateLoaded(AppRoutes.intro, response.data));
              },
            );
          } else {
            Future.delayed(const Duration(milliseconds: 3000), () {
              if (isGuest && _userRepository.isUserAuthenticated()) {
                _userRepository.clearUserData();
                _userRepository.saveUserAuthenticatedStatus(false);
                emit(SplashStateLoaded(AppRoutes.signIn));
              } else {
                if (_userRepository.isUserAuthenticated()) {
                  emit(SplashStateLoaded(AppRoutes.main));
                } else {
                  emit(SplashStateLoaded(AppRoutes.signIn));
                }
              }
            });
          }
        },
      ),
    );
  }

  Future<Either<AppFailure, Unit>> _setFirebaseTokenToConfig(
    BuildContext context,
  ) async {
    try {
      if (await HelperFunctions.isConnectedToInternet()) {
        final pushToken = await FirebaseMessaging.instance.getToken();
        if (pushToken == null) {
          return Left(AppFailure(
            AppStrings.noInternetConnectionException.tr(),
            StatusCode.serverError,
          ));
        } else {
          ServiceLocator.saveConfig(
            Config(
              deviceToken: await HelperFunctions.getDeviceId(),
              pushToken: pushToken,
              languageCode:
                  LanguageManager.getCurrentLocale(context).languageCode,
            ),
          );
          return const Right(unit);
        }
      } else {
        return Left(AppFailure(
          AppStrings.noInternetConnectionException.tr(),
          StatusCode.serverError,
        ));
      }
    } catch (error) {
      return Left(AppFailure(
        error.toString(),
        StatusCode.serverError,
      ));
    }
  }
}
