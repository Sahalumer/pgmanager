// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pgmanager/screens/inside/create_house.dart';

class FirstSignIn extends StatelessWidget {
  final String name;
  const FirstSignIn({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 33, 90),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 170,
              ),
              Image.asset('Assets/Logo/Logo.png'),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    onCreateHomeButton(context);
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Create Home',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  onCreateHomeButton(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (ctx) => CreateHouse(
                  name: name,
                )));
  }
}
