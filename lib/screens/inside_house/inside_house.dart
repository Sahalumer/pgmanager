// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/databaseconnection/house_db.dart';
import 'package:pgmanager/functions/delete_functions.dart';
import 'package:pgmanager/functions/show_errors.dart';
import 'package:pgmanager/model/house_model.dart';
import 'package:pgmanager/screens/inside_house/edit_floors_rooms.dart';
import 'package:pgmanager/screens/inside_house/inside_floor.dart';
import 'package:pgmanager/screens/inside_house/payment_dues.dart';
import 'package:pgmanager/screens/inside_house/revenue.dart';

class HouseHomePage extends StatefulWidget {
  final int houseKey;
  final String houseName;
  final String ownerName;
  const HouseHomePage(
      {super.key,
      required this.houseKey,
      required this.houseName,
      required this.ownerName});

  @override
  State<HouseHomePage> createState() => _HouseHomePageState();
}

class _HouseHomePageState extends State<HouseHomePage> {
  late Future<House> _houseFuture;

  @override
  void initState() {
    super.initState();
    _houseFuture = getHouseByKeyAsync(widget.houseKey);
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
          title: Text(widget.houseName),
          actions: [
            IconButton(
              onPressed: () {
                delete(context, widget.houseKey, widget.ownerName);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.primary.color,
                ),
                child: Image.asset('Assets/Image/LogoImage.png'),
              ),
              ListTile(
                title: const Text('Incompleted Payments'),
                onTap: () async {
                  House house = await getHouseByKeyAsync(widget.houseKey);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDues(
                          house: house,
                        ),
                      ));
                },
              ),
              ListTile(
                title: const Text('Revenue'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleHouseRevenue(
                            houseKey: widget.houseKey,
                            houseName: widget.houseName),
                      ));
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder<House>(
          future: _houseFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              int itemcount = snapshot.data!.floorCount;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: itemcount + 1,
                  itemBuilder: (context, index) {
                    int floorName = index + 1;
                    final List<int> roomCount = [];
                    for (int i = 0; i < itemcount; i++) {
                      roomCount.add(snapshot.data!.roomCount[i].length);
                    }

                    if (index != itemcount) {
                      final bedSpace =
                          findBedSpaceAvailableByFloor(snapshot.data!);
                      return Card(
                        color: AppColor.primary.color,
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            'Floor No: $floorName',
                            style: TextStyle(
                              color: AppColor.white.color,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            '${bedSpace[index]} Bed Space Available ',
                            style: TextStyle(
                              color: AppColor.red.color,
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => InsideFloor(
                                          floorName: 'Floor No: $floorName',
                                          roomCount: roomCount[index],
                                          house: snapshot.data!,
                                          index: index,
                                        ))).then((value) {
                              if (value != null) {
                                setState(() {
                                  _houseFuture =
                                      getHouseByKeyAsync(snapshot.data!.key);
                                });
                              } else {
                                setState(() {
                                  _houseFuture =
                                      getHouseByKeyAsync(snapshot.data!.key);
                                });
                              }
                            });
                          },
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomElevatedButton(
                          buttonText: "Edit The Floors And Rooms",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => EditFloorsAndRooms(
                                        house: snapshot.data!))).then((value) {
                              if (value != null) {
                                setState(() {
                                  _houseFuture =
                                      getHouseByKeyAsync(widget.houseKey);
                                });
                              }
                            });
                          },
                        ),
                      );
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
