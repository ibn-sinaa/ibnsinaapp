part of 'main_cubit.dart';

class MainState extends Equatable {
  final int index;
  final bool refresh;

  const MainState({
    required this.index,
    required this.refresh,
  });

  factory MainState.init() {
    return const MainState(
      index: 0,
      refresh: false,
    );
  }

  MainState copyWith({
    int? index,
    bool? refresh,
  }) {
    return MainState(
      index: index ?? this.index,
      refresh: refresh ?? this.refresh,
    );
  }

  @override
  List<Object> get props => [index, refresh];
}
