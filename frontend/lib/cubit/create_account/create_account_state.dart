part of 'create_account_cubit.dart';

class CreateAccountState extends Equatable {
  final RequestState requestState;
  final String message;
  final CreateAccountStep createAccountStep;
  final String userName;
  final String password;
  final String confirmPassword;
  final bool showPassword;
  final bool showConfirmPassword;
  final EducationalLevel? educationalLevel;
  final String? universityName;
  final CareerModel? careerLevel;
  final bool showError;
  final bool refreshState;
  final bool isAgree;
  final bool showAgreeError;

  const CreateAccountState({
    required this.requestState,
    required this.message,
    required this.createAccountStep,
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.showPassword,
    required this.showConfirmPassword,
    this.educationalLevel,
    this.universityName,
    this.careerLevel,
    required this.showError,
    required this.refreshState,
    required this.isAgree,
    required this.showAgreeError,
  });

  factory CreateAccountState.init() {
    return const CreateAccountState(
      requestState: RequestState.none,
      message: '',
      createAccountStep: CreateAccountStep.otp,
      userName: '',
      password: '',
      confirmPassword: '',
      showPassword: false,
      showConfirmPassword: false,
      showError: false,
      refreshState: false,
      isAgree: false,
      showAgreeError: false,
    );
  }

  CreateAccountState copyWith({
    RequestState? requestState,
    String? message,
    CreateAccountStep? createAccountStep,
    String? userName,
    String? password,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
    EducationalLevel? educationalLevel,
    String? universityName,
    CareerModel? careerLevel,
    bool? showError,
    bool? refreshState,
    bool? isAgree,
    bool? showAgreeError,
  }) {
    return CreateAccountState(
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
      createAccountStep: createAccountStep ?? this.createAccountStep,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      educationalLevel: educationalLevel ?? this.educationalLevel,
      universityName: universityName ?? this.universityName,
      careerLevel: careerLevel ?? this.careerLevel,
      refreshState: refreshState ?? this.refreshState,
      isAgree: isAgree ?? this.isAgree,
      showAgreeError: showAgreeError ?? this.showAgreeError,
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [
        requestState,
        message,
        createAccountStep,
        userName,
        password,
        confirmPassword,
        showPassword,
        showConfirmPassword,
        educationalLevel,
        universityName,
        careerLevel,
        showError,
        refreshState,
        isAgree,
        showAgreeError,
      ];
}
