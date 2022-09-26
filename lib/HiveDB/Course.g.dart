// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 2;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      name: fields[0] as String,
      branch: fields[1] as String,
      credits: fields[5] as Credits,
      comCode: fields[3] as int,
      courseNo: fields[4] as String,
      ic: fields[7] as p.Professor,
      uid: fields[8] as String,
      slides: (fields[6] as List).cast<Slide>(),
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.branch)
      ..writeByte(3)
      ..write(obj.comCode)
      ..writeByte(4)
      ..write(obj.courseNo)
      ..writeByte(5)
      ..write(obj.credits)
      ..writeByte(6)
      ..write(obj.slides)
      ..writeByte(7)
      ..write(obj.ic)
      ..writeByte(8)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
