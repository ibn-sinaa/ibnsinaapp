// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amount_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmountModelAdapter extends TypeAdapter<AmountModel> {
  @override
  final int typeId = 1;

  @override
  AmountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AmountModel(
      id: fields[0] as int,
      key: fields[1] as num,
      value: fields[2] as num,
      offer: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, AmountModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.offer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
