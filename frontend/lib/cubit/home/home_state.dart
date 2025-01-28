// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<SliderModel> sliders;
  final List<CategoryModel> categories;
  final List<HomeModel> homeData;

  const HomeLoaded({
    required this.sliders,
    required this.categories,
    required this.homeData,
  });

  @override
  List<Object> get props => [
        sliders,
        categories,
        homeData,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
