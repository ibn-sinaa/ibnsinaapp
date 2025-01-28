part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashStateInit extends SplashState {}

class SplashStateLoading extends SplashState {}

class SplashStateLoaded extends SplashState {
  final List<IntroModel>? introData;
  final String route;

  SplashStateLoaded(this.route, [this.introData]);
  @override
  List<Object?> get props => [route];
}

class SplashStateError extends SplashState {
  final String message;

  SplashStateError(this.message);
  @override
  List<Object?> get props => [message];
}
