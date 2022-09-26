// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Paper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaperAdapter extends TypeAdapter<Paper> {
  @override
  final int typeId = 5;

  @override
  Paper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Paper(
      paperUrl: fields[0] as String,
      sem: fields[1] as int,
      course: fields[2] as c.Course,
      professor: fields[3] as p.Professor,
      paperType: fields[4] as String,
      solutionUrl: fields[5] as String,
      date: fields[6] as DateTime,
      uid: fields[7] as String,
      average: fields[8] as int,
      highest: fields[9] as int,
      total: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Paper obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.paperUrl)
      ..writeByte(1)
      ..write(obj.sem)
      ..writeByte(2)
      ..write(obj.course)
      ..writeByte(3)
      ..write(obj.professor)
      ..writeByte(4)
      ..write(obj.paperType)
      ..writeByte(5)
      ..write(obj.solutionUrl)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.uid)
      ..writeByte(8)
      ..write(obj.average)
      ..writeByte(9)
      ..write(obj.highest)
      ..writeByte(10)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
