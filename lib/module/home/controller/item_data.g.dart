// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemDataAdapter extends TypeAdapter<ItemData> {
  @override
  final int typeId = 0;

  @override
  ItemData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemData(
      systolic: fields[0] as String,
      diastolic: fields[1] as String,
      pulse: fields[2] as String,
      dateTime: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.systolic)
      ..writeByte(1)
      ..write(obj.diastolic)
      ..writeByte(2)
      ..write(obj.pulse)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
