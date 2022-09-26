// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Professor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfessorAdapter extends TypeAdapter<Professor> {
  @override
  final int typeId = 3;

  @override
  Professor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Professor(
      name: fields[0] as String,
      id: fields[1] as String,
      branch: fields[2] as String,
      chamber: fields[3] as String,
      uid: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Professor obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.branch)
      ..writeByte(3)
      ..write(obj.chamber)
      ..writeByte(4)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfessorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
