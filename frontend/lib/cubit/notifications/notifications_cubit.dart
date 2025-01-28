import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/enums.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/profile_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final ProfileRepository _profileRepository;

  NotificationsCubit(this._profileRepository)
      : super(NotificationsState.init());

  int _page = 1;
  int _lastPage = 1;

  getNotifications() async {
    _page = 1;
    emit(state.copyWith(
      requestState: RequestState.loading,
      moreState: RequestState.none,
      deleteState: RequestState.none,
    ));
    final responseEither = await _profileRepository.getNotifications(_page);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        _page++;
        _lastPage = response.paginate!.lastPage;
        emit(state.copyWith(
          requestState: RequestState.loaded,
          notifications: response.data,
        ));
      },
    );
  }

  loadMoreNotifications() async {
    if (_page > _lastPage || state.moreState == RequestState.loading) {
      return;
    }
    emit(state.copyWith(
      moreState: RequestState.loading,
      deleteState: RequestState.none,
    ));
    final responseEither = await _profileRepository.getNotifications(_page);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          moreState: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        _page++;
        final notifications = [...state.notifications];
        notifications.addAll(response.data);
        emit(state.copyWith(
          moreState: RequestState.loaded,
          notifications: notifications,
        ));
      },
    );
  }

  deleteNotification(int id) async {
    emit(state.copyWith(
      deleteState: RequestState.loading,
      moreState: RequestState.none,
    ));

    final responseEither = await _profileRepository.deleteNotification(id);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          deleteState: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        final notifications = [...state.notifications];
        final deletedNotification =
            notifications.firstWhere((notification) => notification.id == id);
        notifications.remove(deletedNotification);
        emit(state.copyWith(
          deleteState: RequestState.loaded,
          message: response.message,
          notifications: notifications,
        ));
      },
    );
  }
}
