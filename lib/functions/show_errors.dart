// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:pgmanager/databaseconnection/person_functions.dart';
import 'package:pgmanager/model/house_model.dart';

List<int> findBedSpaceAvailableByFloor(House house) {
  return house.roomCount.map((rooms) {
    int temp = rooms.fold(0, (sum, e) => sum + e.bedSpaceCount);
    int personCount = rooms.fold(0, (sum, e) => sum + e.persons.length);
    return temp - personCount;
  }).toList();
}

List<int> findBedSpaceAvailablebyRooms(House house, int index) {
  List<int> counts = [];
  for (var rooms in house.roomCount) {
    for (var room in rooms) {
      counts.add(room.bedSpaceCount - room.persons.length);
    }
  }
  return counts;
}

int findBedSpaceAvailablebyHouse(House house) {
  List<int> counts = [];
  for (var rooms in house.roomCount) {
    for (var room in rooms) {
      counts.add(room.bedSpaceCount - room.persons.length);
    }
  }
  int value = counts.reduce((value, element) => value + element);

  return value;
}

ValueNotifier<List<Person>> peymentdues = ValueNotifier([]);

getIncompletedPaymentBysingleHouse(House house) {
  peymentdues.value.clear();
  List<Person> value = [];
  for (var rooms in house.roomCount) {
    for (var room in rooms) {
      for (var person in room.persons) {
        if (person.isPayed == false) {
          value.add(person);
        }
      }
    }
  }
  peymentdues.value.addAll(value);
  peymentdues.notifyListeners();
}

getIncompletedPaymentByHouses(List<House> houses) {
  peymentdues.value.clear();
  List<Person> value = [];
  for (var house in houses) {
    for (var rooms in house.roomCount) {
      for (var room in rooms) {
        for (var person in room.persons) {
          if (person.isPayed == false) {
            value.add(person);
          }
        }
      }
    }
  }
  peymentdues.value.addAll(value);
  peymentdues.notifyListeners();
}

updateisPayedByMonth(List<House> houses) async {
  final now = DateTime.now();
  final intMonth = now.month;
  List<String> months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String currentMonth = months[intMonth];

  for (var house in houses) {
    for (var floor in house.roomCount) {
      for (var rooms in floor) {
        for (var person in rooms.persons) {
          if (person.revenue.keys.last != currentMonth) {
            person.isPayed = false;
            await updatePersonInRoomAsync(house.key, person.roomName, person);
          }
        }
      }
    }
  }
}
