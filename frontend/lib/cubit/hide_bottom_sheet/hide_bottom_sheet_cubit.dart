import 'package:bloc/bloc.dart';

class HideBottomSheetCubit extends Cubit<bool> {
  HideBottomSheetCubit() : super(true);

  void hide() {
    emit(!state);
  }
}
