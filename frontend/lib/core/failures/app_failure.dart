import 'package:equatable/equatable.dart';

class AppFailure extends Equatable {
  final String message;
  final int statusCode;

  const AppFailure(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
