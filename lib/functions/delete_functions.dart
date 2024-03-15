// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pgmanager/databaseconnection/house_db.dart';
import 'package:pgmanager/screens/inside/home.dart';

delete(BuildContext context, int key, String ownerName) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(
          'Are You Confirm To Delete?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await deleteHouseAsync(key);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => Home(name: ownerName)),
                  (route) => false);
              msg(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

void msg(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        "Deletd Your  House",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.grey,
    ),
  );
}
