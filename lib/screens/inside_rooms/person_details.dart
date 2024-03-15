// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/databaseconnection/person_functions.dart';
import 'package:pgmanager/model/house_model.dart';
import 'package:pgmanager/screens/inside_rooms/see_details.dart';
import 'package:pgmanager/screens/inside_rooms/update_payment.dart';

class PersonDetails extends StatefulWidget {
  final int houseKey;
  final String personName;
  final String roomName;
  final int index;
  const PersonDetails(
      {super.key,
      required this.houseKey,
      required this.personName,
      required this.roomName,
      required this.index});

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  late Future<Person?> _personFuture;

  @override
  void initState() {
    super.initState();
    _personFuture = loadPerson();
  }

  Future<Person?> loadPerson() async {
    return getPersonByName(widget.houseKey, widget.roomName, widget.personName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary.color,
          centerTitle: true,
          foregroundColor: AppColor.white.color,
          toolbarHeight: 65,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Client'),
          actions: [
            IconButton(
              onPressed: () {
                delete(context);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: FutureBuilder<Person?>(
          future: _personFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              Person person = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColor.primary.color,
                      width: MediaQuery.of(context).size.width * .90,
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                AssetImage('Assets/Image/users.png'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(
                                  color: AppColor.white.color,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                person.name,
                                style: TextStyle(
                                  color: AppColor.white.color,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Phone Number : ',
                                style: TextStyle(
                                  color: AppColor.white.color,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                person.phoneNumber.toString(),
                                style: TextStyle(
                                  color: AppColor.white.color,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              updatePayment(context, person, widget.houseKey,
                                  widget.roomName);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              minimumSize: const Size(210, 43),
                              backgroundColor: Colors.white,
                            ),
                            child: const Text('Payment'),
                          ),
                          const SizedBox(height: 5.1),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => SeeDetails(
                                    person: person,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'See Details>>',
                              style: TextStyle(color: AppColor.white.color),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: person.isPayed ? false : true,
                      child: const Text(
                        "Payment Expired... Update It! ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
          },
        ),
      ),
    );
  }

  delete(BuildContext context) {
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
                await deletePersonAsync(
                    widget.houseKey, widget.roomName, widget.index);
                Navigator.pop(context);
                Navigator.pop(context);
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
          "Deletd succusfully",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
