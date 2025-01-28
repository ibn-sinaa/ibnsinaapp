part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final String phone;
  final String password;
  final String message;
  final RequestState requestState;
  final bool showPassword;
  final bool showError;
  final bool refreshState;

  const SignInState({
    required this.phone,
    required this.password,
    required this.message,
    required this.requestState,
    required this.showPassword,
    required this.showError,
    required this.refreshState,
  });

  factory SignInState.init() {
    return const SignInState(
      phone: '',
      password: '',
      message: '',
      requestState: RequestState.none,
      showPassword: false,
      showError: false,
      refreshState: false,
    );
  }

  SignInState copyWith({
    String? phone,
    String? password,
    String? message,
    RequestState? requestState,
    bool? showPassword,
    bool? showError,
    bool? rememberMe,
    bool? refreshState,
  }) {
    return SignInState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      message: message ?? this.message,
      requestState: requestState ?? this.requestState,
      showPassword: showPassword ?? this.showPassword,
      showError: showError ?? this.showError,
      refreshState: refreshState ?? this.refreshState,
    );
  }

  @override
  List<Object> get props {
    return [
      phone,
      password,
      message,
      requestState,
      showPassword,
      showError,
      refreshState
    ];
  }
}
