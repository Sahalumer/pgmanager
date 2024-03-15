// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pgmanager/databaseconnection/Admin_Entry_db.dart';
import 'package:pgmanager/model/admin_model.dart';
import 'package:pgmanager/screens/Authonications/login_page.dart';

class ResetPassWord extends StatelessWidget {
  final String name;

  ResetPassWord({super.key, required this.name});

  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 33, 90),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('Assets/Image/LogoImage.png'),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.key_outlined, color: Colors.white, size: 25),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Reset Your Password',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 65,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(255, 217, 217, 217),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is Empty";
                      } else if (value.length < 6) {
                        return "Minimum 6 Characters";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    controller: rePasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(255, 217, 217, 217),
                      hintText: 'Re-Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Re-Password is Empty";
                      } else if (value.length < 6) {
                        return "Minimum 6 Characters";
                      } else if (value != passwordController.text) {
                        return "Passwords do not match";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(250, 53),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    onResetPasswordButton(context);
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onResetPasswordButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final newPassword = passwordController.text;
      final foundAdmin = await getAdminByName(name);

      if (foundAdmin != null) {
        final updatedAdmin = AdminEntry(
            name: foundAdmin.name,
            email: foundAdmin.email,
            password: newPassword);

        updateAdmin(foundAdmin.key, updatedAdmin);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => LoginPage()),
          (route) => false,
        );
      }
    }
  }
}
