part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final RequestState requestState;
  final String message;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConfirmNewPassword;
  final bool showError;

  const ChangePasswordState({
    required this.requestState,
    required this.message,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.showCurrentPassword,
    required this.showNewPassword,
    required this.showConfirmNewPassword,
    required this.showError,
  });

  factory ChangePasswordState.init() {
    return const ChangePasswordState(
      requestState: RequestState.none,
      message: '',
      currentPassword: '',
      newPassword: '',
      confirmNewPassword: '',
      showCurrentPassword: false,
      showNewPassword: false,
      showConfirmNewPassword: false,
      showError: false,
    );
  }

  ChangePasswordState copyWith({
    RequestState? requestState,
    String? message,
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
    bool? showCurrentPassword,
    bool? showNewPassword,
    bool? showConfirmNewPassword,
    bool? showError,
  }) {
    return ChangePasswordState(
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmNewPassword:
          showConfirmNewPassword ?? this.showConfirmNewPassword,
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object> get props {
    return [
      requestState,
      message,
      currentPassword,
      newPassword,
      confirmNewPassword,
      showCurrentPassword,
      showNewPassword,
      showConfirmNewPassword,
      showError,
    ];
  }
}
