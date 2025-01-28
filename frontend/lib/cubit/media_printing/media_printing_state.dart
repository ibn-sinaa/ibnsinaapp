part of 'media_printing_cubit.dart';

class MediaPrintingState extends Equatable {
  final RequestState requestState;
  final String message;
  final List<MediaFormModel> forms;

  final OptionModel? materialOption;
  final num totalPrice;
  final bool refreshData;

  const MediaPrintingState({
    required this.requestState,
    required this.message,
    required this.forms,
    this.materialOption,
    required this.totalPrice,
    required this.refreshData,
  });

  factory MediaPrintingState.initial() {
    return MediaPrintingState(
      requestState: RequestState.none,
      message: '',
      forms: [MediaFormModel.generateForm()],
      totalPrice: 0,
      refreshData: false,
    );
  }

  MediaPrintingState copyWith({
    RequestState? requestState,
    String? message,
    List<MediaFormModel>? forms,
    OptionModel? materialOption,
    num? totalPrice,
    bool? refreshData,
  }) {
    return MediaPrintingState(
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
      forms: forms ?? this.forms,
      materialOption: materialOption ?? this.materialOption,
      totalPrice: totalPrice ?? this.totalPrice,
      refreshData: refreshData ?? this.refreshData,
    );
  }

  @override
  List<Object?> get props {
    return [
      requestState,
      message,
      forms,
      materialOption,
      totalPrice,
      refreshData,
    ];
  }
}
