// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/databaseconnection/house_db.dart';
import 'package:pgmanager/databaseconnection/person_functions.dart';
import 'package:pgmanager/model/house_model.dart';

class EditFloorsAndRooms extends StatefulWidget {
  final House house;

  const EditFloorsAndRooms({super.key, required this.house});

  @override
  State<EditFloorsAndRooms> createState() => _EditFloorsAndRoomsState();
}

class _EditFloorsAndRoomsState extends State<EditFloorsAndRooms> {
  final formKey = GlobalKey<FormState>();
  final newFloorCountController = TextEditingController();
  List<TextEditingController> newRoomCountControllers = [];

  @override
  void initState() {
    super.initState();
    assignValue();
    newFloorCountController.addListener(() {
      setState(() {
        updateRoomCountControllers();
      });
    });
  }

  @override
  void dispose() {
    newFloorCountController.dispose();
    for (var controller in newRoomCountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primary.color,
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Floor Count',
                        style: TextStyle(color: AppColor.white.color),
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        labelText: 'Floor Count',
                        hintText: "Enter The Floor Count",
                        controller: newFloorCountController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      for (int i = 0; i < newRoomCountControllers.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room Count in Floor ${i + 1}',
                              style: TextStyle(color: AppColor.white.color),
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              labelText: 'Room Count',
                              hintText: "Enter The Room Count",
                              controller: newRoomCountControllers[i],
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                              buttonText: 'Back',
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          CustomTextButton(
                            buttonText: "Update",
                            onPressed: () {
                              inUpdateButton();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void assignValue() {
    newFloorCountController.text = widget.house.floorCount.toString();
    updateRoomCountControllers();
    for (int i = 0; i < newRoomCountControllers.length; i++) {
      newRoomCountControllers[i].text = i < widget.house.roomCount.length
          ? widget.house.roomCount[i].length.toString()
          : '';
    }
  }

  void updateRoomCountControllers() {
    int currentRoomCount = int.tryParse(newFloorCountController.text) ?? 0;
    setState(() {
      if (currentRoomCount > newRoomCountControllers.length) {
        newRoomCountControllers.addAll(
          List.generate(
            currentRoomCount - newRoomCountControllers.length,
            (index) => TextEditingController(
              text: index < widget.house.roomCount.length
                  ? widget.house.roomCount[index].length.toString()
                  : '',
            ),
          ),
        );
      } else {
        newRoomCountControllers.removeRange(
          currentRoomCount,
          newRoomCountControllers.length,
        );
      }
    });
  }

  Future<void> inUpdateButton() async {
    if (formKey.currentState!.validate()) {
      final houseName = widget.house.houseName;
      final ownerName = widget.house.ownerName;
      final floorCount = newFloorCountController.text.trim();
      final roomCount = newRoomCountControllers
          .map((controller) => controller.text.trim())
          .toList();
      final List<List<Room>> rooms = [];
      for (int i = 0; i < roomCount.length; i++) {
        int count = int.parse(roomCount[i]);
        List<Room> value = [];
        for (int j = 0; j < count; j++) {
          List<Person> persons =
              await getPersonsByRoomName(widget.house.key, '$i+$j+$houseName');
          Room temp = Room(
            roomName: '$i+$j+$houseName',
            persons: persons.isEmpty ? [] : persons,
            bedSpaceCount: persons.isEmpty ? 1 : persons.length,
          );
          value.add(temp);
        }
        rooms.add(value);
      }
      final updatedHouse = House(
        houseName: houseName,
        floorCount: int.parse(floorCount),
        roomCount: rooms,
        ownerName: ownerName,
      );
      await updateHouseAsync(widget.house.key, updatedHouse);

      Navigator.pop(context, updatedHouse);
    }
  }
}
