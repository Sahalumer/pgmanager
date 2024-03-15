import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/functions/show_errors.dart';
import 'package:pgmanager/model/house_model.dart';
import 'package:pgmanager/screens/inside_rooms/inside_room.dart';

class InsideFloor extends StatefulWidget {
  final String floorName;
  final int roomCount;
  final House house;
  final int index;
  const InsideFloor(
      {super.key,
      required this.floorName,
      required this.roomCount,
      required this.house,
      required this.index});

  @override
  State<InsideFloor> createState() => _InsideFloorState();
}

class _InsideFloorState extends State<InsideFloor> {
  late List<int> bedSpace;
  @override
  void initState() {
    super.initState();
    bedSpace = findBedSpaceAvailablebyRooms(widget.house, widget.index);
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
        title: Text(widget.floorName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: widget.roomCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, gridIndex) {
          return InkWell(
            onTap: () {
              List<Room> room = widget.house.roomCount[widget.index];

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => InsideRoom(
                            roomName: room[gridIndex].roomName,
                            house: widget.house,
                          ))).then((_) {
                setState(() {
                  bedSpace =
                      findBedSpaceAvailablebyRooms(widget.house, widget.index);
                });
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 17,
                  ),
                  const Icon(
                    Icons.touch_app,
                    size: 90,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Tap To View',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: bedSpace[gridIndex] != 0,
                    child: Text(
                      '${bedSpace[gridIndex]} bedSpace Available',
                      style: TextStyle(color: AppColor.red.color),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
