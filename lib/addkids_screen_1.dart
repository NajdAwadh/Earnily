// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'export.dart';

import 'package:intl/intl.dart';
//import 'package:flutter_poolakey/flutter_poolakey.dart';
import 'dart:ui' as ui;

class AddKids_screen_1 extends StatefulWidget {
  const AddKids_screen_1({Key? key}) : super(key: key);

  @override
  _AddKids_screen_1 createState() => _AddKids_screen_1();
}

class _AddKids_screen_1 extends State<AddKids_screen_1> {
  final List<String> items = <String>["ذكر", "أنثى"];
  String? value;

  DateTime? date;

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

    double widthScale = width / 390;
    double heightScale = height / 844;

    return Scaffold(
      backgroundColor: FvColors.screen1Background,
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
//-- Component Bottom --//
                Positioned(
                  left: 0,
                  top: 761,
                  child: Container(
                    width: 390,
                    height: 83,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(206, 217, 217, 217),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),

//-- End Bottom --//
//-- Component InviteRectangleContainer_5 --//
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 390,
                    height: 150,
                    decoration: BoxDecoration(
                      color: FvColors.scrollcontainer3Background,
                      borderRadius: BorderRadius.circular(37),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                    ),
                  ),
                ),

//-- End InviteRectangleContainer_5 --//
//-- Component homebutton_ImageView_11 --//
                Positioned(
                  left: 155,
                  top: 741,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child:
                        Image.asset("assets/homebutton_ImageView_11-80x80.png"),
                  ),
                ),
//-- End homebutton_ImageView_11 --//
//-- Component tasks_ImageView_12 --//
                Positioned(
                  left: 19,
                  top: 761,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset("assets/tasks_ImageView_12-60x60.png"),
                  ),
                ),
//-- End tasks_ImageView_12 --//
//-- Component award_ImageView_13 --//
                Positioned(
                  left: 311,
                  top: 761,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset("assets/award_ImageView_13-60x60.png"),
                  ),
                ),
//-- End award_ImageView_13 --//
//-- Component InviteButton --//
                Positioned(
                    left: 21,
                    top: 653,
                    child: SizedBox(
                        width: 347,
                        height: 68,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor:
                                FvColors.scrollcontainer3Background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(56),
                              side: const BorderSide(
                                width: 0,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const KidsjoinviaQRcode_screen_1();
                                },
                              ),
                            ); // push
                          },
                          child: const Text('إضافة ',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: FvColors.textview24FontColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                              )),
                        ))),
//-- End InviteButton --//
//-- Component InviteTextView --//

                const Positioned(
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
                          backgroundColor: FvColors.textview24Background,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    ))),
//-- End InviteTextView --//
//-- Component Tasks_TextView_16 --//
                const Positioned(
                    left: 18,
                    top: 821,
                    child: Text(
                      "Tasks",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Tasks_TextView_16 --//
//-- Component Home_TextView_17 --//
                const Positioned(
                    left: 155,
                    top: 821,
                    child: Text(
                      "Home",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Home_TextView_17 --//
//-- Component Rewards_TextView_18 --//
                const Positioned(
                    left: 315,
                    top: 821,
                    child: Text(
                      "Rewards",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Rewards_TextView_18 --//
//-- Component BirthdayTextBox --//
                Positioned(
                  right: 107,
                  top: 406,
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
                            color: FvColors.scrollcontainer3Background,
                          ),
                        ),
                      ),
                      child: Text(
                        getText(),
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            backgroundColor: FvColors.textview24Background,
                            color: FvColors.textview24FontColor,
                            wordSpacing: 1.0),
                      )),
                ),

//-- End BirthdayTextBox --//
//-- Component BirthdayTextView --//
/*
                const Positioned(
                    left: 280,
                    top: 406,
                    child: SizedBox(
                        child: Text(
                      "تاريخ الميلاد",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          backgroundColor: FvColors.textview24Background,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    ))),
                  
//-- End BirthdayTextView --//
*/
//-- Component GenderTextBox --//
                Positioned(
                    right: 107,
                    top: 287,
                    width: 254,
                    height: 66,
                    child: DropdownButton<String>(
                        hint: const Text("الجنس"),
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
                        })),

//-- End GenderTextBox --//
//-- Component GenderTextView --//
                const Positioned(
                    left: 300,
                    top: 292,
                    child: SizedBox(
                        child: Text(
                      "الجنس",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          backgroundColor: FvColors.textview24Background,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    ))),
//-- End GenderTextView --//
//-- Component NameTextBox --//
                Positioned(
                    right: 107,
                    top: 178,
                    width: 251,
                    height: 66,
                    /*child: Container(
                      width: 251 * widthScale,
                      height: 66 * heightScale,
                      decoration: BoxDecoration(
                        color: FvColors.textview24Background,
                        borderRadius: BorderRadius.circular(56),
                        border: Border.all(),
                      ),*/
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 5,
                            color: FvColors.scrollcontainer3Background,
                          ),
                          borderRadius: BorderRadius.circular(56.0),
                        ),
                        hintText: "الأسم",
                        hintTextDirection: ui.TextDirection.rtl,
                      ),
                    ) //),
                    ),

//-- End NameTextBox --//
//-- Component NameTextView --//
                const Positioned(
                    left: 300,
                    top: 178,
                    child: SizedBox(
                        child: Text(
                      "الأسم",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          backgroundColor: FvColors.textview24Background,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    ))),
//-- End NameTextView --//
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
