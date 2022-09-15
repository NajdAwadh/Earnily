// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:earnily/reuasblewidgets.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'kidsjoinviaQRcode_screen_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddKids_screen_1 extends StatefulWidget {
  const AddKids_screen_1({Key? key}) : super(key: key);

  @override
  _AddKids_screen_1 createState() => _AddKids_screen_1();
}

class _AddKids_screen_1 extends State<AddKids_screen_1> {
  final List<String> items = <String>["ذكر", "أنثى"];
  String? value;
  DateTime? date;

  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _dateController = TextEditingController();

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
            ),
            content: Text(
              "ادخل البيانات المطلوبة",
              textAlign: TextAlign.right,
            ),
          );
        });
  }

  void _validate() {
    if (_nameController.text.isEmpty || value == null || date == null) {
      _showDialog();
    } else {
      addKidDetails();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const KidsjoinviaQRcode_screen_1();
          },
        ),
      );
    } // push
  }

  Future addKidDetails() async {
    await FirebaseFirestore.instance.collection('kids').add({
      'name': _nameController.text,
      'gender': value,
      'date': date,
    });
  }

  void _showDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(2001),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        date = value!;
      });
    });
  }

  String getText() {
    if (date == null) {
      return "اختر تاريخ الميلاد";
    } else {
      return DateFormat("dd/MM/yyyy").format(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          'أضافة طفل',
          style: TextStyle(fontSize: 40),
        ),
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(children: [
                const SizedBox(height: 844, width: 390),
                /*
//-- Component Bottom --//
                Positioned(
                  left: 0,
                  top: 740,
                  child: Container(
                    width: 390,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(206, 217, 217, 217),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
//-- End Bottom --//

//-- Component homebutton_ImageView_11 --//
                const Positioned(
                  left: 155,
                  top: 741,
                  child: SizedBox(
                    //width: 80,
                    //height: 80,
                    child: Icon(
                      Icons.home_filled,
                      color: Colors.blue,
                      size: 60.0,
                    ),
                    //Image.asset("assets/homebutton_ImageView_11-80x80.png"),
                  ),
                ),
//-- End homebutton_ImageView_11 --//

//-- Component tasks_ImageView_12 --//
                const Positioned(
                  left: 19,
                  top: 761,
                  child: SizedBox(
                    //width: 60,
                    //height: 60,
                    child: Icon(
                      Icons.task_outlined,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    //Image.asset("assets/tasks_ImageView_12-60x60.png"),
                  ),
                ),
//-- End tasks_ImageView_12 --//

//-- Component award_ImageView_13 --//
                const Positioned(
                  left: 311,
                  top: 761,
                  child: SizedBox(
                    //width: 60,
                    //height: 60,
                    child: Icon(
                      Icons.celebration,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    //Image.asset("assets/award_ImageView_13-60x60.png"),
                  ),
                ),
//-- End award_ImageView_13 --//

//-- Component Tasks_TextView_16 --//
                const Positioned(
                    left: 18,
                    top: 800,
                    child: Text(
                      "المهام",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Tasks_TextView_16 --//
//-- Component Home_TextView_17 --//
                const Positioned(
                    left: 155,
                    top: 800,
                    child: Text(
                      "المنزل",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Home_TextView_17 --//
//-- Component Rewards_TextView_18 --//
                const Positioned(
                    left: 315,
                    top: 800,
                    child: Text(
                      "المكافأت",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Rewards_TextView_18 --//
*/
//-- Component InviteRectangleContainer_5 --//

//-- End InviteRectangleContainer_5 --//
//-- Component InviteTextView --//

                /*  const Positioned(
                    left: 86,
                    top: 23,
                    child: SizedBox(
                        child: Text(
                      "إضافة إبن/أبنة",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          wordSpacing: 1.0),
                    ))),*/

//-- End InviteTextView --//

//-- Component profile_ImageView_17 --//
                //  Positioned(
                //     left: 276,
                //    top: 14,
                //     child: SizedBox(
                //       width: 85,
                //      height: 85,
                //      child: Image.asset("assets/profile_ImageView_17-85x85.png"),
                //   ),
                //  ),
//-- End profile_ImageView_17 --//

//-- Component NameTextView --//

                reuasbleTextField("الاسم الكامل", Icons.person, false,
                    TextEditingController()),

//-- End NameTextView --//

//-- Component NameTextBox --//
                Positioned(
                    right: 107,
                    top: 178,
                    width: 251,
                    height: 66,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 5, color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(56.0),
                        ),
                        hintText: "الأسم",
                        hintTextDirection: ui.TextDirection.rtl,
                      ),
                    )
                    //),
                    ),

//-- End NameTextBox --//

//-- Component GenderTextView --//
                const Positioned(
                    left: 300,
                    top: 300,
                    child: SizedBox(
                        child: Text(
                      "الجنس",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          wordSpacing: 1.0),
                    ))),
//-- End GenderTextView --//

//-- Component GenderTextBox --//
                Positioned(
                    right: 107,
                    top: 300,
                    width: 254,
                    height: 66,
                    child: Container(
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(56),
                          border: const Border(
                            left: BorderSide(
                              width: 5,
                              color: Colors.blueAccent,
                            ),
                            right: BorderSide(
                              width: 5,
                              color: Colors.blueAccent,
                            ),
                            top: BorderSide(
                              width: 5,
                              color: Colors.blueAccent,
                            ),
                            bottom: BorderSide(
                              width: 5,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        child: DropdownButton<String>(
                            hint: const Text(
                              "الجنس",
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.right,
                            ),
                            value: value,
                            items: items.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                value = newVal!;
                              });
                            }))),

//-- End GenderTextBox --//

//-- Component BirthdayTextView --//
                const Positioned(
                    left: 280,
                    top: 425,
                    child: SizedBox(
                        child: Text(
                      "تاريخ الميلاد",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          wordSpacing: 1.0),
                    ))),

//-- End BirthdayTextView --//

//-- Component BirthdayTextBox --//
                Positioned(
                  right: 107,
                  top: 425,
                  width: 254,
                  height: 66,
                  child: ElevatedButton(
                      onPressed: _showDatePicker,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56),
                          side: const BorderSide(
                            width: 5,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      child: Text(
                        getText(),
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        textDirection: ui.TextDirection.rtl,
                      )),
                ),

//-- End BirthdayTextBox --//

//-- Component InviteButton --//
                Positioned(
                    left: 21,
                    top: 625,
                    child: SizedBox(
                        width: 347,
                        height: 68,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(56),
                              side: const BorderSide(
                                width: 0,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          onPressed: _validate,
                          child: const Text('إضافة ',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                              )),
                        ))),
//-- End InviteButton --//
              ]),
            ),
//-- Component ScrollContainer --//
//-- End ScrollContainer --//
          ],
        ),
      ),
    );
  }
}
