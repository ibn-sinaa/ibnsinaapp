part of 'contact_us_cubit.dart';

class ContactUsState extends Equatable {
  final RequestState requestState;
  final String requestMessage;
  final String userName;
  final String phone;
  final String email;
  final String message;
  final bool showError;
  final bool refreshState;

  const ContactUsState({
    required this.requestState,
    required this.requestMessage,
    required this.userName,
    required this.phone,
    required this.email,
    required this.message,
    required this.showError,
    required this.refreshState,
  });

  factory ContactUsState.init() {
    return const ContactUsState(
      requestState: RequestState.none,
      requestMessage: '',
      userName: '',
      phone: '',
      email: '',
      message: '',
      showError: false,
      refreshState: false,
    );
  }

  ContactUsState copyWith({
    RequestState? requestState,
    String? requestMessage,
    String? userName,
    String? phone,
    String? email,
    String? message,
    bool? showError,
    bool? refreshState,
  }) {
    return ContactUsState(
      requestState: requestState ?? this.requestState,
      requestMessage: requestMessage ?? this.requestMessage,
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      message: message ?? this.message,
      showError: showError ?? this.showError,
      refreshState: refreshState ?? this.refreshState,
    );
  }

  @override
  List<Object> get props {
    return [
      requestState,
      requestMessage,
      userName,
      phone,
      email,
      message,
      showError,
      refreshState,
    ];
  }
}
