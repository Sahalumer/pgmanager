// ignore_for_file: file_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pgmanager/model/admin_model.dart';

ValueNotifier<List<AdminEntry>> adminList = ValueNotifier([]);
const String adminBoxName = "adminDb";

void addAdmin(AdminEntry admin) async {
  final adminbox = await Hive.openBox<AdminEntry>(adminBoxName);
  await adminbox.add(admin);

  adminList.value.add(admin);
  adminList.notifyListeners();
}

void getAllAdmins() async {
  final adminbox = await Hive.openBox<AdminEntry>(adminBoxName);
  adminList.value.clear();
  adminList.value.addAll(adminbox.values);
  adminList.notifyListeners();
}

void updateAdmin(int id, AdminEntry admin) async {
  // Open the box if not opened yet
  if (!Hive.isBoxOpen('admin db')) {
    final adminBox = await Hive.openBox<AdminEntry>(adminBoxName);
    adminBox.put(id, admin);
  } else {
    final adminBox = Hive.box<AdminEntry>(adminBoxName);
    adminBox.put(id, admin);
  }
  getAllAdmins();
}

Future<bool> checkCredentials(String name, String password) async {
  final adminBox = await Hive.openBox<AdminEntry>(adminBoxName);
  if (adminBox.containsKey(name)) {
    final adminEntry = adminBox.get(name);
    if (adminEntry != null && adminEntry.password == password) {
      return true;
    }
  }

  return false;
}

Future<AdminEntry?> getAdminByName(String name) async {
  final adminBox = await Hive.openBox<AdminEntry>(adminBoxName);
  // print(l[0].password);
  // if (adminBox.containsKey(name)) {
  final adminEntry = adminBox.values.firstWhere(
    (entry) {
      if (entry.name == name) {
        return true;
      } else {
        return false;
      }
    },
    orElse: () => AdminEntry(name: '', email: '', password: ''),
  );

  return adminEntry;
  // }

  // return null;
}

Future<AdminEntry?> getAdminByEmail(String email) async {
  final adminBox = await Hive.openBox<AdminEntry>(adminBoxName);

  final adminEntry = adminBox.values.firstWhere(
    (entry) {
      if (entry.email == email) {
        return true;
      } else {
        return false;
      }
    },
    orElse: () => AdminEntry(name: '', email: '', password: ''),
  );

  return adminEntry;
  // }

  // return null;
}
