// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// to Select the Color
enum AppColor {
  primary,
  secondary,
  white,
  red,
}

extension AppColorExtension on AppColor {
  Color get color {
    switch (this) {
      case AppColor.primary:
        return const Color.fromARGB(255, 1, 33, 90);

      case AppColor.white:
        return const Color.fromARGB(255, 255, 255, 255);
      case AppColor.secondary:
        return const Color.fromARGB(255, 209, 206, 191);
      case AppColor.red:
        return Colors.red;
    }
  }
}

// to Create Custom TextFormField
class CustomTextField extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? controller;
  TextInputType? keyboardType;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromARGB(255, 217, 217, 217),
          hintText: hintText,
          labelText: null,
          labelStyle: const TextStyle(
            color: Colors.black,
          )),
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is empty';
        } else {
          return null;
        }
      },
    );
  }
}

// To Create CustomElevatedButton

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomElevatedButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        minimumSize: const Size(350, 43),
        backgroundColor: Colors.white,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

// to Create CustomTextButton

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const CustomTextButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
