import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshCubit extends Cubit<bool> {
  RefreshCubit() : super(true);

  refresh() {
    emit(!state);
  }
}
