// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 6;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as num,
      offerPrice: fields[4] as num,
      startAmount: fields[5] as num,
      amounts: (fields[6] as List).cast<AmountModel>(),
      defaultOptions: (fields[7] as List).cast<DefaultOptionModel>(),
      mainImage: fields[8] as String,
      images: (fields[9] as List).cast<String>(),
      categories: (fields[10] as List).cast<CategoryModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.offerPrice)
      ..writeByte(5)
      ..write(obj.startAmount)
      ..writeByte(6)
      ..write(obj.amounts)
      ..writeByte(7)
      ..write(obj.defaultOptions)
      ..writeByte(8)
      ..write(obj.mainImage)
      ..writeByte(9)
      ..write(obj.images)
      ..writeByte(10)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
