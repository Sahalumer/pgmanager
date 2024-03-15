// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/databaseconnection/person_functions.dart';
import 'package:pgmanager/model/house_model.dart';

class AddPerson extends StatefulWidget {
  final int houseKey;
  final String roomName;

  const AddPerson({
    super.key,
    required this.houseKey,
    required this.roomName,
  });

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final monthController = TextEditingController();
  String? selectedMonth;
  bool isPayed = false;
  File? imagePath;
  String? selectedImage;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    amountController.text = '0';
    isSelected = List<bool>.filled(2, false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primary.color,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('Assets/Image/LogoImage.png'),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.730,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17)),
                      color: AppColor.white.color,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .32,
                                  ),
                                  const Text(
                                    'Add Client',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Name',
                                    ),
                                    CustomTextField(
                                      labelText: "Name",
                                      hintText: "Enter The Name",
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Phone Number',
                                    ),
                                    CustomTextField(
                                      labelText: "Phone Number",
                                      hintText: "Enter The Phone Number",
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Join Date'),
                                    InkWell(
                                      onTap: () {
                                        toSelectDate();
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextField(
                                          labelText: "Join Month",
                                          hintText: "dd/mm/year",
                                          controller: monthController,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text('ID Proof'),
                              ),
                              if (selectedImage == null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      selectImageSource();
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Add Image'),
                                  ),
                                ),
                              if (selectedImage != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: _buildImagePreview(),
                                ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .03,
                                  ),
                                  const Text(
                                    'Is Payment Completed',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ToggleButtons(
                                      isSelected: isSelected,
                                      onPressed: (int index) {
                                        setState(() {
                                          isPayed = index == 0;
                                          for (int buttonIndex = 0;
                                              buttonIndex < isSelected.length;
                                              buttonIndex++) {
                                            isSelected[buttonIndex] =
                                                buttonIndex == index;
                                          }
                                        });
                                      },
                                      children: const [
                                        Text('Yes'),
                                        Text('No'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (isPayed)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Month',
                                          ),
                                          DropdownButtonFormField(
                                            value: selectedMonth,
                                            items: months.map((String month) {
                                              return DropdownMenuItem<String>(
                                                value: month,
                                                child: Text(month),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              selectedMonth = value;
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 217, 217, 217),
                                              hintText: "Select the Month",
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select the Month';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Amount',
                                          ),
                                          CustomTextField(
                                            labelText: 'Amount',
                                            hintText: 'Enter the Amount',
                                            controller: amountController,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                minimumSize: const Size(250, 53),
                                backgroundColor: AppColor.primary.color,
                              ),
                              onPressed: () {
                                onAddButton();
                              },
                              child: const Text(
                                'ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      imagePath = File(pickedImage.path);
      selectedImage = pickedImage.path;
    });
  }

  Future<void> pickImageFromcamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;

    setState(() {
      imagePath = File(pickedImage.path);
      selectedImage = pickedImage.path;
    });
  }

  void onAddButton() async {
    if (formKey.currentState!.validate()) {
      if (selectedImage == null) {
        msg(context);
      }

      final person = Person(
          name: nameController.text,
          phoneNumber: int.parse(phoneController.text),
          imagePath: selectedImage!,
          isPayed: isPayed,
          roomName: widget.roomName,
          joinDate: monthController.text,
          revenue: {
            isPayed ? selectedMonth! : '': int.parse(amountController.text),
          });
      await addPersonInRoomAsync(
        widget.houseKey,
        widget.roomName,
        person,
      );
      Navigator.pop(context);
    }
  }

  void msg(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Please add the Id Proof',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.grey,
      ),
    );
  }

  toSelectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        monthController.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      }
    });
  }

  Widget _buildImagePreview() {
    return Column(
      children: [
        if (selectedImage != null)
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(selectedImage!)),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            selectImageSource();
          },
          child: const Text('Change Image'),
        ),
      ],
    );
  }

  Future<void> selectImageSource() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: MediaQuery.of(context).size.height * .12,
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        pickImageFromcamera();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.camera_enhance),
                      label: const Text("Camera")),
                  TextButton.icon(
                      onPressed: () {
                        pickImageFromGallery();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("gallery"))
                ],
              )),
        );
      },
    );
  }
}
