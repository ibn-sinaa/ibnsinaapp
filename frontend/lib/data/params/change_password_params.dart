class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;
  final String passwordConfirmation;

  ChangePasswordParams(
    this.currentPassword,
    this.newPassword,
    this.passwordConfirmation,
  );

  Map<String, String> toMap() {
    return {
      'old_password': currentPassword,
      'password': newPassword,
      'password_confirmation': passwordConfirmation,
    };
  }
}
