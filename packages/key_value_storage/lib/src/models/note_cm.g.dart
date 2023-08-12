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
      content: (fields[1] as List).cast<dynamic>(),
      title: fields[2] as String,
      body: fields[3] as String,
      updatedDate: fields[5] as DateTime,
      folder: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteCM obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.folder)
      ..writeByte(5)
      ..write(obj.updatedDate);
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
