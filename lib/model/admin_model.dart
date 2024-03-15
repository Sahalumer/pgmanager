// ignore_for_file: file_names

import 'package:hive_flutter/hive_flutter.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 1)
class AdminEntry extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  AdminEntry({required this.name, required this.email, required this.password});
}
