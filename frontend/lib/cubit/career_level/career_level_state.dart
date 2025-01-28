part of 'career_level_cubit.dart';

abstract class CareerLevelState extends Equatable {
  const CareerLevelState();

  @override
  List<Object> get props => [];
}

class CareerLevelInitial extends CareerLevelState {}

class CareerLevelLoading extends CareerLevelState {}

class CareerLevelLoaded extends CareerLevelState {
  final List<CareerModel> careerLevels;

  const CareerLevelLoaded(this.careerLevels);

  @override
  List<Object> get props => [careerLevels];
}

class CareerLevelError extends CareerLevelState {
  final String message;

  const CareerLevelError(this.message);

  @override
  List<Object> get props => [message];
}
