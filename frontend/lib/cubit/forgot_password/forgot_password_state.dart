part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final RequestState requestState;
  final ForgotPasswordStep forgotPasswordStep;
  final String message;
  final String phone;
  final String otp;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final bool showError;
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConfirmNewPassword;
  final bool refreshState;

  const ForgotPasswordState({
    required this.requestState,
    required this.forgotPasswordStep,
    required this.message,
    required this.phone,
    required this.otp,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.showError,
    required this.showCurrentPassword,
    required this.showNewPassword,
    required this.showConfirmNewPassword,
    required this.refreshState,
  });

  factory ForgotPasswordState.init() {
    return const ForgotPasswordState(
      requestState: RequestState.none,
      forgotPasswordStep: ForgotPasswordStep.phone,
      message: '',
      phone: '',
      otp: '',
      currentPassword: '',
      newPassword: '',
      confirmNewPassword: '',
      showError: false,
      showCurrentPassword: false,
      showNewPassword: false,
      showConfirmNewPassword: false,
      refreshState: false,
    );
  }

  ForgotPasswordState copyWith({
    RequestState? requestState,
    ForgotPasswordStep? forgotPasswordStep,
    String? message,
    String? phone,
    String? otp,
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
    bool? showError,
    bool? showCurrentPassword,
    bool? showNewPassword,
    bool? showConfirmNewPassword,
    bool? refreshState,
  }) {
    return ForgotPasswordState(
      requestState: requestState ?? this.requestState,
      forgotPasswordStep: forgotPasswordStep ?? this.forgotPasswordStep,
      message: message ?? this.message,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      showError: showError ?? this.showError,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmNewPassword:
          showConfirmNewPassword ?? this.showConfirmNewPassword,
      refreshState: refreshState ?? this.refreshState,
    );
  }

  @override
  List<Object> get props => [
        requestState,
        forgotPasswordStep,
        message,
        phone,
        otp,
        currentPassword,
        newPassword,
        confirmNewPassword,
        showError,
        showCurrentPassword,
        showNewPassword,
        showConfirmNewPassword,
        refreshState,
      ];
}
