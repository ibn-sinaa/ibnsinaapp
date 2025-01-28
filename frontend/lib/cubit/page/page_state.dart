part of 'page_cubit.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class PageStateInitial extends PageState {}

class PageStateLoading extends PageState {}

class PageStateLoaded extends PageState {
  final PageModel pageModel;

  const PageStateLoaded(this.pageModel);

  @override
  List<Object> get props => [pageModel];
}

class PageStateError extends PageState {
  final String message;

  const PageStateError(this.message);

  @override
  List<Object> get props => [message];
}
