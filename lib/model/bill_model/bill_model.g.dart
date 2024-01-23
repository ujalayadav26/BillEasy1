// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillModelAdapter extends TypeAdapter<BillModel> {
  @override
  final int typeId = 0;

  @override
  BillModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillModel(
      id: fields[0] as int?,
      buyerName: fields[1] as String?,
      buyerAddress: fields[2] as String?,
      buyerMobile: fields[3] as String?,
      parsDisOnTotal: fields[4] as String?,
      buyStuff: (fields[5] as List?)?.cast<BillStuffModel>(),
      dateAndTime: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BillModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.buyerName)
      ..writeByte(2)
      ..write(obj.buyerAddress)
      ..writeByte(3)
      ..write(obj.buyerMobile)
      ..writeByte(4)
      ..write(obj.parsDisOnTotal)
      ..writeByte(5)
      ..write(obj.buyStuff)
      ..writeByte(6)
      ..write(obj.dateAndTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillStuffModelAdapter extends TypeAdapter<BillStuffModel> {
  @override
  final int typeId = 1;

  @override
  BillStuffModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillStuffModel(
      stuffName: fields[0] as String?,
      stuffPrice: fields[1] as String?,
      stuffCount: fields[2] as String?,
      parsDisOnStuff: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BillStuffModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.stuffName)
      ..writeByte(1)
      ..write(obj.stuffPrice)
      ..writeByte(2)
      ..write(obj.stuffCount)
      ..writeByte(3)
      ..write(obj.parsDisOnStuff);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillStuffModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
