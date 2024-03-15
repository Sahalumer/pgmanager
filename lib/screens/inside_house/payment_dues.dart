// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/databaseconnection/house_db.dart';
import 'package:pgmanager/functions/show_errors.dart';
import 'package:pgmanager/model/house_model.dart';
import 'package:pgmanager/screens/inside_rooms/person_details.dart';

class PaymentDues extends StatelessWidget {
  PaymentDues({super.key, this.house, this.houses});
  House? house;
  List<House>? houses;
  @override
  Widget build(BuildContext context) {
    assignValue();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary.color,
        centerTitle: true,
        foregroundColor: AppColor.white.color,
        toolbarHeight: 65,
        title: const Text("Incompleted Payments"),
      ),
      body: ValueListenableBuilder(
          valueListenable: peymentdues,
          builder: (BuildContext context, List<Person> list, Widget? child) {
            return list.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(list[index].name),
                              subtitle:
                                  Text(list[index].phoneNumber.toString()),
                              onTap: () async {
                                House? houseForKey = await getHouseByRoomName(
                                    list[index].roomName);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => PersonDetails(
                                            houseKey: houseForKey!.key,
                                            personName: list[index].name,
                                            roomName: list[index].roomName,
                                            index: index)));
                              },
                            ),
                          );
                        }),
                  )
                : const Center(
                    child: Text("Every One Done Payment"),
                  );
          }),
    ));
  }

  assignValue() {
    if (house != null) {
      getIncompletedPaymentBysingleHouse(house!);
    } else if (houses != null) {
      getIncompletedPaymentByHouses(houses!);
    }
  }
}
