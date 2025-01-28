part of 'paper_printing_cubit.dart';

class PaperPrintingState extends Equatable {
  final RequestState requestState;
  final RequestState submitState;
  final String message;
  final bool refreshData;
  final File? file;
  final int copiesCount;
  final int pageCount;
  final OptionDataModel? printingColor;
  final List<OptionDataModel> printingColors;
  final List<OptionModel> options;
  final num totalPrice;
  final num optionsPrice;

  const PaperPrintingState({
    required this.requestState,
    required this.submitState,
    required this.message,
    required this.refreshData,
    required this.copiesCount,
    required this.pageCount,
    required this.printingColors,
    required this.options,
    this.file,
    this.printingColor,
    this.totalPrice = 0,
    this.optionsPrice = 0,
  });

  factory PaperPrintingState.initial() {
    return const PaperPrintingState(
      requestState: RequestState.none,
      submitState: RequestState.none,
      message: '',
      refreshData: true,
      copiesCount: 1,
      pageCount: 1,
      options: [],
      printingColors: [],
    );
  }

  PaperPrintingState copyWith({
    RequestState? requestState,
    RequestState? submitState,
    String? message,
    bool? refreshData,
    File? file,
    int? copiesCount,
    int? pageCount,
    OptionDataModel? printingColor,
    List<OptionDataModel>? printingColors,
    List<OptionModel>? options,
    num? totalPrice,
    num? optionsPrice,
  }) {
    return PaperPrintingState(
      requestState: requestState ?? this.requestState,
      submitState: submitState ?? this.submitState,
      message: message ?? this.message,
      refreshData: refreshData ?? this.refreshData,
      file: file ?? this.file,
      copiesCount: copiesCount ?? this.copiesCount,
      pageCount: pageCount ?? this.pageCount,
      printingColor: printingColor ?? this.printingColor,
      printingColors: printingColors ?? this.printingColors,
      options: options ?? this.options,
      totalPrice: totalPrice ?? this.totalPrice,
      optionsPrice: optionsPrice ?? this.optionsPrice,
    );
  }

  @override
  List<Object?> get props {
    return [
      requestState,
      submitState,
      message,
      refreshData,
      file,
      copiesCount,
      pageCount,
      printingColor,
      printingColors,
      options,
      totalPrice,
      optionsPrice,
    ];
  }
}
