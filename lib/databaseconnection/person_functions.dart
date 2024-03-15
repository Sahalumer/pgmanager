import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pgmanager/model/house_model.dart';

ValueNotifier<List<House>> houseList = ValueNotifier([]);

const String houseBoxName = "House Db";

Future<Box<House>> openHouseBox() async {
  return await Hive.openBox<House>(houseBoxName);
}

closeHouseBox(Box<House>? box) async {
  if (box != null && box.isOpen) {
    await box.close();
  }
}

Future<void> addPersonInRoomAsync(
  int houseKey,
  String roomName,
  Person updatedPerson,
) async {
  final houseBox = await openHouseBox();
  try {
    House? house = houseBox.get(houseKey);

    if (house != null) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          if (room.roomName == roomName) {
            room.persons.add(updatedPerson);
            await houseBox.put(houseKey, house);

            return;
          }
        }
      }
    }
  } finally {
    closeHouseBox(houseBox);
  }
}

Future<void> updatePersonInRoomAsync(
    int houseKey, String roomName, Person updatedPerson) async {
  final houseBox = await openHouseBox();
  try {
    House? house = houseBox.get(houseKey);

    if (house != null) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          if (room.roomName == roomName) {
            int index = room.persons
                .indexWhere((person) => person.name == updatedPerson.name);

            if (index != -1) {
              room.persons[index] = updatedPerson;
              await houseBox.put(houseKey, house);
            }

            return;
          }
        }
      }
    }
  } finally {
    closeHouseBox(houseBox);
  }
}

Future<Person?> getPersonByName(
    int houseKey, String roomName, String personName) async {
  final houseBox = await openHouseBox();
  try {
    House? house = houseBox.get(houseKey);

    if (house != null) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          if (room.roomName == roomName) {
            return room.persons.firstWhere(
                (person) => person.name == personName,
                orElse: () => Person(
                    name: '',
                    phoneNumber: 0,
                    imagePath: '',
                    isPayed: false,
                    joinDate: '',
                    revenue: {},
                    roomName: ''));
          }
        }
      }
    }
    return null;
  } finally {
    closeHouseBox(houseBox);
  }
}

Future<void> deletePersonAsync(
  int houseKey,
  String roomName,
  int index,
) async {
  final houseBox = await openHouseBox();
  try {
    House? house = houseBox.get(houseKey);

    if (house != null) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          if (room.roomName == roomName) {
            room.persons.removeAt(index);
            await houseBox.put(houseKey, house);

            return;
          }
        }
      }
    }
  } finally {
    closeHouseBox(houseBox);
  }
}

Future<List<Person>> getPersonsByRoomName(int houseKey, String roomName) async {
  final houseBox = await openHouseBox();
  try {
    House? house = houseBox.get(houseKey);

    if (house != null) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          if (room.roomName == roomName) {
            return room.persons;
          }
        }
      }
    }
    return [];
  } finally {
    await closeHouseBox(houseBox);
  }
}
