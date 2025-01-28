part of 'home_products_cubit.dart';

abstract class HomeProductsState extends Equatable {
  const HomeProductsState();

  @override
  List<Object> get props => [];
}

class HomeProductsInitial extends HomeProductsState {}

class HomeProductsLoading extends HomeProductsState {}

class HomeProductsLoaded extends HomeProductsState {
  final List<HomeModel> homeData;

  const HomeProductsLoaded(this.homeData);

  @override
  List<Object> get props => [homeData];
}

class HomeProductsError extends HomeProductsState {
  final String message;

  const HomeProductsError(this.message);

  @override
  List<Object> get props => [message];
}
