import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.init());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  goToScreenWithIndex(int index, {bool refresh = false}) {
    emit(state.copyWith(
      index: index,
      refresh: refresh,
    ));
  }
}
