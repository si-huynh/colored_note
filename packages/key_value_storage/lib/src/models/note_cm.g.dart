// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteCMAdapter extends TypeAdapter<NoteCM> {
  @override
  final int typeId = 0;

  @override
  NoteCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteCM(
      id: fields[0] as String,
      title: fields[1] as String,
      body: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
