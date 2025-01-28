part of 'delete_account_cubit.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountLoaded extends DeleteAccountState {
  final String message;

  DeleteAccountLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteAccountError extends DeleteAccountState {
  final String message;

  DeleteAccountError(this.message);

  @override
  List<Object> get props => [message];
}
