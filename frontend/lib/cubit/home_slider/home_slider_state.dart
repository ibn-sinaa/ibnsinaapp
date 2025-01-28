part of 'home_slider_cubit.dart';

abstract class HomeSliderState extends Equatable {
  const HomeSliderState();

  @override
  List<Object> get props => [];
}

class HomeSliderInitial extends HomeSliderState {}

class HomeSliderLoading extends HomeSliderState {}

class HomeSliderLoaded extends HomeSliderState {
  final List<SliderModel> sliders;

  const HomeSliderLoaded(this.sliders);

  @override
  List<Object> get props => [sliders];
}

class HomeSliderError extends HomeSliderState {
  final String message;
  final int statusCode;

  const HomeSliderError(this.message, this.statusCode);

  @override
  List<Object> get props => [message];
}
