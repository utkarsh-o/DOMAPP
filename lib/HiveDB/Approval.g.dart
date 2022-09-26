// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Approval.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApprovalAdapter extends TypeAdapter<Approval> {
  @override
  final int typeId = 8;

  @override
  Approval read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Approval(
      uid: fields[0] as String,
      accepts: fields[1] as int,
      description: fields[2] as String,
      reference: fields[3] as String,
      rejects: fields[4] as int,
      approvalType: fields[5] as String,
      user: fields[6] as u.User,
      referredObject: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Approval obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.accepts)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.reference)
      ..writeByte(4)
      ..write(obj.rejects)
      ..writeByte(5)
      ..write(obj.approvalType)
      ..writeByte(6)
      ..write(obj.user)
      ..writeByte(7)
      ..write(obj.referredObject);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApprovalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
