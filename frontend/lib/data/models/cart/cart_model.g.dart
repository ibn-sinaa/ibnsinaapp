// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 2;

  @override
  CartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModel(
      id: fields[0] as String,
      productId: fields[1] as int,
      productName: fields[2] as String,
      productImage: fields[3] as String,
      amount: fields[4] as AmountModel,
      totalPrice: fields[5] as num,
      options: (fields[6] as List).cast<OptionDataModel>(),
      defaultOptions: (fields[7] as List).cast<DefaultOptionModel>(),
      filePath: fields[8] as String?,
      message: fields[9] as String,
      createdAt: fields[10] as DateTime,
      optionsModels: (fields[11] as List).cast<OptionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.productName)
      ..writeByte(3)
      ..write(obj.productImage)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.totalPrice)
      ..writeByte(6)
      ..write(obj.options)
      ..writeByte(7)
      ..write(obj.defaultOptions)
      ..writeByte(8)
      ..write(obj.filePath)
      ..writeByte(9)
      ..write(obj.message)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.optionsModels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
