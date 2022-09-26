// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Credits.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditsAdapter extends TypeAdapter<Credits> {
  @override
  final int typeId = 7;

  @override
  Credits read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Credits(
      practicals: fields[0] as int,
      lectures: fields[1] as int,
    )..units = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, Credits obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.practicals)
      ..writeByte(1)
      ..write(obj.lectures)
      ..writeByte(2)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
