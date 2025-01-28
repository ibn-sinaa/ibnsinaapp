part of 'user_cubit.dart';

class UserState extends Equatable {
  final String userName;
  final String image;
  final RequestState requestState;
  final String message;

  const UserState({
    required this.userName,
    required this.image,
    required this.requestState,
    required this.message,
  });

  factory UserState.init(UserModel user) {
    return UserState(
      userName: user.userName,
      image: user.image,
      requestState: RequestState.none,
      message: '',
    );
  }

  UserState copyWith({
    String? userName,
    String? image,
    RequestState? requestState,
    String? message,
  }) {
    return UserState(
      userName: userName ?? this.userName,
      image: image ?? this.image,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        userName,
        image,
        requestState,
        message,
      ];
}
