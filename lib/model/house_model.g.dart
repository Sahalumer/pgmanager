// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseAdapter extends TypeAdapter<House> {
  @override
  final int typeId = 2;

  @override
  House read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return House(
      houseName: fields[0] as String,
      floorCount: fields[1] as int,
      roomCount: (fields[2] as List)
          .map((dynamic e) => (e as List).cast<Room>())
          .toList(),
      ownerName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, House obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.houseName)
      ..writeByte(1)
      ..write(obj.floorCount)
      ..writeByte(2)
      ..write(obj.roomCount)
      ..writeByte(3)
      ..write(obj.ownerName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoomAdapter extends TypeAdapter<Room> {
  @override
  final int typeId = 3;

  @override
  Room read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Room(
      roomName: fields[0] as String,
      persons: (fields[1] as List).cast<Person>(),
      bedSpaceCount: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.roomName)
      ..writeByte(1)
      ..write(obj.persons)
      ..writeByte(2)
      ..write(obj.bedSpaceCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 4;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      name: fields[0] as String,
      phoneNumber: fields[1] as int,
      imagePath: fields[3] as String,
      isPayed: fields[2] as bool,
      joinDate: fields[4] as String,
      revenue: (fields[6] as Map).cast<String, int>(),
      roomName: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.isPayed)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.joinDate)
      ..writeByte(5)
      ..write(obj.roomName)
      ..writeByte(6)
      ..write(obj.revenue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
