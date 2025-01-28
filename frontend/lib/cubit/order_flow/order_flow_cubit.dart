import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/helper_functions.dart';
import '../../data/models/amount/amount_model.dart';
import '../../data/models/option_model/option_model.dart';
import '../../data/models/product/product_model.dart';
import '../../data/repositories/user_repository.dart';

import '../../data/models/cart/cart_model.dart';
import '../../data/models/option_data/option_data_model.dart';

class OrderFlowCubit extends Cubit<CartModel> {
  final UserRepository _userRepository;

  OrderFlowCubit(this._userRepository) : super(CartModel.init());

  generateCart(
    ProductModel productModel,
    List<DefaultOptionModel> defaultOptions,
  ) {
    emit(
      CartModel.generateCart(
        productModel,
        defaultOptions,
      ),
    );
  }

  changeAmount(AmountModel amount) {
    final optionsPrice = _calcOptionsPrice(state.options);

    emit(
      state.copyWith(
        amount: amount,
        totalPrice:
            optionsPrice + (amount.offer != 0 ? amount.offer : amount.value),
      ),
    );
  }

  addFile(String? filePath) {
    emit(state.copyWith(
      filePath: filePath,
      removeFilePath: filePath == null,
    ));
  }

  addCheckBoxOption(OptionDataModel option, OptionModel optionModel) {
    final options = [...state.options];
    option.isSelected = true;
    options.add(option);

    final optionsModels = [...state.optionsModels];
    if (!optionsModels.contains(optionModel)) {
      optionsModels.add(optionModel);
    }
    emit(
      state.copyWith(
        totalPrice: state.totalPrice + option.price,
        options: options,
        optionsModels: optionsModels,
      ),
    );
  }

  removeOption(OptionDataModel option, OptionModel optionModel) {
    final options = [...state.options];
    option.isSelected = false;
    options.remove(option);

    final optionsModels = [...state.optionsModels];
    bool isEmpty = true;
    for (var optioData in optionModel.data) {
      if (optioData.isSelected) {
        isEmpty = false;
        break;
      }
    }
    if (isEmpty) {
      optionsModels.remove(optionModel);
    }
    emit(
      state.copyWith(
        totalPrice: state.totalPrice - option.price,
        options: options,
        optionsModels: optionsModels,
      ),
    );
  }

  addRadioOption(OptionDataModel option, OptionModel optionModel) {
    final options = [...state.options];
    num removedPrice = 0;

    for (final optionDataModel in optionModel.data) {
      if (optionDataModel.isSelected) {
        removedPrice = optionDataModel.price;
        optionDataModel.isSelected = false;
        options.remove(optionDataModel);
        break;
      }
    }
    option.isSelected = true;
    options.add(option);

    final optionsModels = [...state.optionsModels];
    if (!optionsModels.contains(optionModel)) {
      optionsModels.add(optionModel);
    }

    emit(
      state.copyWith(
        totalPrice: state.totalPrice + option.price - removedPrice,
        options: options,
        optionsModels: optionsModels,
      ),
    );
  }

  num _calcOptionsPrice(List<OptionDataModel> options) {
    return state.options.fold<num>(0, (prev, current) => prev + current.price);
  }

  addToCart(String message) {
    final cartModel = state.copyWith(
      id: HelperFunctions.generateTimeBasedId(),
      createdAt: DateTime.now(),
      message: message,
    );
    _userRepository.addToCart(cartModel);
  }
}
