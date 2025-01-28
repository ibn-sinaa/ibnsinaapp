part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final String phone;
  final String message;
  final RequestState requestState;
  final bool showError;
  final bool refreshState;

  const SignUpState({
    required this.phone,
    required this.message,
    required this.requestState,
    required this.showError,
    required this.refreshState,
  });
  factory SignUpState.init() {
    return const SignUpState(
      phone: '',
      message: '',
      requestState: RequestState.none,
      showError: false,
      refreshState: false,
    );
  }

  SignUpState copyWith({
    String? phone,
    String? message,
    RequestState? requestState,
    bool? showError,
    bool? refreshState,
  }) {
    return SignUpState(
      phone: phone ?? this.phone,
      message: message ?? this.message,
      requestState: requestState ?? this.requestState,
      showError: showError ?? this.showError,
      refreshState: refreshState ?? this.refreshState,
    );
  }

  @override
  List<Object> get props => [
        phone,
        message,
        requestState,
        showError,
        refreshState,
      ];
}
