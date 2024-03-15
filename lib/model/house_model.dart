// ignore_for_file: file_names

import 'package:hive_flutter/hive_flutter.dart';
part 'house_model.g.dart';

@HiveType(typeId: 2)
class House extends HiveObject {
  @HiveField(0)
  String houseName;
  @HiveField(1)
  int floorCount;
  @HiveField(2)
  List<List<Room>> roomCount;
  @HiveField(3)
  String ownerName;

  House({
    required this.houseName,
    required this.floorCount,
    required this.roomCount,
    required this.ownerName,
  });
}

@HiveType(typeId: 3)
class Room {
  @HiveField(0)
  String roomName;
  @HiveField(1)
  List<Person> persons;
  @HiveField(2)
  int bedSpaceCount;

  Room(
      {required this.roomName,
      required this.persons,
      required this.bedSpaceCount});

  factory Room.fromMap(Map<String, dynamic> data) {
    return Room(
      roomName: data['roomName'],
      persons: (data['persons'] as List<dynamic>)
          .map((personData) => Person.fromMap(personData))
          .toList(),
      bedSpaceCount: data['bedSpaceCount'],
    );
  }
}

@HiveType(typeId: 4)
class Person {
  @HiveField(0)
  String name;
  @HiveField(1)
  int phoneNumber;
  @HiveField(2)
  bool isPayed;
  @HiveField(3)
  String imagePath;
  @HiveField(4)
  String joinDate;
  @HiveField(5)
  String roomName;
  @HiveField(6)
  Map<String, int> revenue;

  Person({
    required this.name,
    required this.phoneNumber,
    required this.imagePath,
    required this.isPayed,
    required this.joinDate,
    required this.revenue,
    required this.roomName,
  });

  factory Person.fromMap(Map<String, dynamic> data) {
    return Person(
        name: data['name'],
        phoneNumber: data['phoneNumber'],
        imagePath: data['imagePath'],
        isPayed: data['isPayed'],
        joinDate: data['joinDate'],
        revenue: data['revenue'],
        roomName: data['roomName']);
  }

  int countTotal() {
    int total = 0;
    revenue.forEach((key, value) {
      total += value;
    });
    return total;
  }

  int countMonth(String key) {
    int total = 0;
    revenue.forEach((revenueKey, value) {
      if (revenueKey == key) {
        total += value;
      }
    });
    return total;
  }
}
