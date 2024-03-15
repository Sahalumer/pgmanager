// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/databaseconnection/house_db.dart';
import 'package:pgmanager/model/house_model.dart';
import 'package:pgmanager/screens/inside_rooms/add_persons.dart';
import 'package:pgmanager/screens/inside_rooms/person_details.dart';

class InsideRoom extends StatefulWidget {
  final House house;
  final String roomName;

  const InsideRoom({super.key, required this.house, required this.roomName});

  @override
  State<InsideRoom> createState() => _InsideRoomState();
}

class _InsideRoomState extends State<InsideRoom> {
  final bedSpaceCountroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primary.color,
        body: FutureBuilder<Room?>(
          future: getRoomByNameInHouseAsync(widget.house.key, widget.roomName),
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
              Room room = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('Assets/Image/LogoImage.png'),
                    Container(
                      color: AppColor.secondary.color,
                      height: MediaQuery.of(context).size.height * .390,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 22),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: room.bedSpaceCount,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (ctx, index) {
                            if (index < room.persons.length) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => PersonDetails(
                                        houseKey: widget.house.key,
                                        personName: room.persons[index].name,
                                        roomName: widget.roomName,
                                        index: index,
                                      ),
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  color: AppColor.white.color,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 2),
                                      Image.asset(
                                        'Assets/Image/users.png',
                                        height: 100,
                                      ),
                                      Text(
                                        room.persons[index].name,
                                        style: TextStyle(
                                            color: room.persons[index].isPayed
                                                ? Colors.black
                                                : Colors.red),
                                      ),
                                      Text(
                                        room.persons[index].phoneNumber
                                            .toString(),
                                        style: TextStyle(
                                            color: room.persons[index].isPayed
                                                ? Colors.black
                                                : Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => AddPerson(
                                        houseKey: widget.house.key,
                                        roomName: widget.roomName,
                                      ),
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  color: AppColor.white.color,
                                  child: const Icon(
                                    Icons.add,
                                    size: 75,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Enter Bed Space Count"),
                            content: TextFormField(
                              controller: bedSpaceCountroller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Enter bed space count",
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  final count =
                                      int.parse(bedSpaceCountroller.text);
                                  await updateRoomBedSpaceCountAsync(
                                      widget.house.key, widget.roomName, count);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Text("Submit"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        "How much bed space?",
                        style: TextStyle(
                          color: AppColor.white.color,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 180,
                      child: CustomElevatedButton(
                        buttonText: 'DONE',
                        onPressed: () => Navigator.pop(
                          context,
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
}
