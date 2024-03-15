import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pgmanager/model/admin_model.dart';
import 'package:pgmanager/model/house_model.dart';
import 'package:pgmanager/screens/Authonications/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(AdminEntryAdapter().typeId)) {
    Hive.registerAdapter(AdminEntryAdapter());
  }
  if (!Hive.isAdapterRegistered(HouseAdapter().typeId)) {
    Hive.registerAdapter(HouseAdapter());
    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(RoomAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      primarySwatch: Colors.blue,
    );
    return MaterialApp(
      title: 'Control Your Home',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
