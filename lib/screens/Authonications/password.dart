// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pgmanager/databaseconnection/Admin_Entry_db.dart';
import 'package:pgmanager/model/admin_model.dart';
import 'package:pgmanager/screens/Authonications/reset_password.dart';

class ForgotPassord extends StatelessWidget {
  ForgotPassord({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 33, 90),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 90,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    '''Forgot
Your Password?''',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                'Assets/Image/forgot Password.png',
                height: 250,
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 217, 217, 217),
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      // minimumSize: const Size(350, 43),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    inNextButton(context);
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: const Text(
                  "Back To Sign-In",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  inNextButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = emailcontroller.text.trim();

      AdminEntry? foundAdmin = await getAdminByEmail(email);

      if (foundAdmin != null && foundAdmin.email == email) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ResetPassWord(
                      name: foundAdmin.name,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Email Address"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
