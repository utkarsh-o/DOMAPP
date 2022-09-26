// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Slide.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SlideAdapter extends TypeAdapter<Slide> {
  @override
  final int typeId = 4;

  @override
  Slide read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Slide(
      url: fields[0] as String,
      date: fields[1] as DateTime,
      sem: fields[2] as int,
      section: fields[3] as int,
      course: fields[4] as c.Course,
      professor: fields[5] as p.Professor,
      slideType: fields[6] as String,
      number: fields[7] as int,
      uid: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Slide obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.sem)
      ..writeByte(3)
      ..write(obj.section)
      ..writeByte(4)
      ..write(obj.course)
      ..writeByte(5)
      ..write(obj.professor)
      ..writeByte(6)
      ..write(obj.slideType)
      ..writeByte(7)
      ..write(obj.number)
      ..writeByte(8)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SlideAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
