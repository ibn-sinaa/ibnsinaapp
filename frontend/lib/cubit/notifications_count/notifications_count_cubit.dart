import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/user_repository.dart';

class NotificationsCountCubit extends Cubit<int> {
  final UserRepository _userRepository;

  NotificationsCountCubit(this._userRepository) : super(0);

  getNotificationsCount() async {
    emit(await _userRepository.getNotificationsCount());
  }

  incrementNotificationsCount() {
    _userRepository.incrementNotificationsCount();
    emit(state + 1);
  }

  resetNotificationsCount() {
    _userRepository.resetNotificationsCount();
    emit(0);
  }
}
