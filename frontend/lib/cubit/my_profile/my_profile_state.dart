part of 'my_profile_cubit.dart';

class MyProfileState extends Equatable {
  final RequestState requestState;
  final RequestState updateState;
  final String message;
  final String image;
  final String userName;
  final String email;
  final EducationalLevel? educationalLevel;
  final String? universityName;
  final CareerModel? careerLevel;
  final bool enableUpdating;
  final bool showError;
  final int? inReview;

  const MyProfileState({
    required this.requestState,
    required this.updateState,
    required this.message,
    required this.image,
    required this.userName,
    required this.email,
    this.educationalLevel,
    this.universityName,
    this.careerLevel,
    required this.enableUpdating,
    required this.showError,
    this.inReview,
  });

  factory MyProfileState.init() {
    return const MyProfileState(
      requestState: RequestState.none,
      updateState: RequestState.none,
      message: '',
      image: '',
      userName: '',
      email: '',
      enableUpdating: false,
      showError: false,
    );
  }

  MyProfileState copyWith({
    RequestState? requestState,
    RequestState? updateState,
    String? message,
    String? image,
    String? userName,
    String? email,
    EducationalLevel? educationalLevel,
    String? universityName,
    CareerModel? careerLevel,
    bool? enableUpdating,
    bool? showError,
    int? inReview,
  }) {
    return MyProfileState(
      requestState: requestState ?? this.requestState,
      updateState: updateState ?? this.updateState,
      message: message ?? this.message,
      image: image ?? this.image,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      educationalLevel: educationalLevel ?? this.educationalLevel,
      universityName: universityName ?? this.universityName,
      careerLevel: careerLevel ?? this.careerLevel,
      enableUpdating: enableUpdating ?? this.enableUpdating,
      showError: showError ?? this.showError,
      inReview: inReview ?? this.inReview,
    );
  }

  @override
  List<Object?> get props {
    return [
      requestState,
      updateState,
      message,
      image,
      userName,
      email,
      educationalLevel,
      universityName,
      careerLevel,
      enableUpdating,
      showError,
      inReview,
    ];
  }
}
