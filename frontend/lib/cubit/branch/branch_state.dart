part of 'branch_cubit.dart';

abstract class BranchState extends Equatable {
  const BranchState();

  @override
  List<Object> get props => [];
}

class BranchInitial extends BranchState {}

class BranchLoading extends BranchState {}

class BranchLoaded extends BranchState {
  final List<BranchModel> branches;

  const BranchLoaded(this.branches);

  @override
  List<Object> get props => [branches];
}

class BranchError extends BranchState {
  final String message;

  const BranchError(this.message);

  @override
  List<Object> get props => [message];
}
