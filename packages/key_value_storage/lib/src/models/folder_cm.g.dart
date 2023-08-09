// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderCMAdapter extends TypeAdapter<FolderCM> {
  @override
  final int typeId = 1;

  @override
  FolderCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderCM(
      id: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FolderCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
