// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'export.dart';

class AddKids_screen_1 extends StatefulWidget {
  const AddKids_screen_1({Key? key}) : super(key: key);

  @override
  _AddKids_screen_1 createState() => _AddKids_screen_1();
}

class _AddKids_screen_1 extends State<AddKids_screen_1> {
  final List<String> items = <String>["ذكر", "أنثى"];
  String? value;

  DateTime date = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2001),
      lastDate: DateTime(2021),
    ).then((value) {
      setState(() {
        date = value!;
      });
    });
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
                    height: 207,
                    decoration: BoxDecoration(
                      color: FvColors.scrollcontainer3Background,
                      borderRadius: BorderRadius.circular(37),
                    ),
                    child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
//-- Component Rectangle_Container_6 --//
                          Positioned(
                            child: Container(
                              width: 390 * widthScale,
                              height: 207 * heightScale,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                              ),
                            ),
                          ),

//-- End Rectangle_Container_6 --//
                        ]),
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
                          child: const Text('إضافة ',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: FvColors.textview24FontColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                              )),
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
                const Positioned(
                    right: 107,
                    top: 406,
                    width: 254,
                    height: 66,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: " تاريخ الميلاد",
                      ),
                    )
                    /*
                    child: MaterialButton(
                        onPressed: _showDatePicker,
                        child: const Text(
                          "اختر تاريخ الميلاد",
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              backgroundColor: FvColors.textview24Background,
                              color: FvColors.textview24FontColor,
                              wordSpacing: 1.0),
                        ))*/
                    ),

//-- End BirthdayTextBox --//
//-- Component BirthdayTextView --//
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
                const Positioned(
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
                        border: OutlineInputBorder(),
                        hintText: "الأسم",
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
