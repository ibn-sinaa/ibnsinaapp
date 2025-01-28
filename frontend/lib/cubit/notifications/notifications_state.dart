part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final RequestState requestState;
  final RequestState moreState;
  final RequestState deleteState;
  final String message;
  final List<NotificationModel> notifications;

  const NotificationsState({
    required this.requestState,
    required this.moreState,
    required this.deleteState,
    required this.message,
    required this.notifications,
  });

  factory NotificationsState.init() {
    return const NotificationsState(
      requestState: RequestState.none,
      moreState: RequestState.none,
      deleteState: RequestState.none,
      message: '',
      notifications: [],
    );
  }

  NotificationsState copyWith({
    RequestState? requestState,
    RequestState? moreState,
    RequestState? deleteState,
    String? message,
    List<NotificationModel>? notifications,
  }) {
    return NotificationsState(
      requestState: requestState ?? this.requestState,
      moreState: moreState ?? this.moreState,
      deleteState: deleteState ?? this.deleteState,
      message: message ?? this.message,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object> get props => [
        requestState,
        moreState,
        deleteState,
        message,
        notifications,
      ];
}
