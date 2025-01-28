// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionModelAdapter extends TypeAdapter<OptionModel> {
  @override
  final int typeId = 3;

  @override
  OptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionModel(
      id: fields[0] as int,
      name: fields[1] as String,
      type: fields[2] as String,
      byCopy: fields[3] as int,
      data: (fields[4] as List).cast<OptionDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OptionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.byCopy)
      ..writeByte(4)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DefaultOptionModelAdapter extends TypeAdapter<DefaultOptionModel> {
  @override
  final int typeId = 4;

  @override
  DefaultOptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DefaultOptionModel(
      key: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DefaultOptionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefaultOptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
