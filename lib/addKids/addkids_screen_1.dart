// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:earnily/models/kids.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'dart:ui';

import '../api/kidsApi.dart';
import '../notifications/notification_api.dart';
import '../notifier/kidsNotifier.dart';
import 'kidsjoinviaQRcode_screen_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddKids_screen_1 extends StatefulWidget {
  const AddKids_screen_1({Key? key}) : super(key: key);

  @override
  _AddKids_screen_1 createState() => _AddKids_screen_1();
}

class _AddKids_screen_1 extends State<AddKids_screen_1> {
  final kidsDb = FirebaseFirestore.instance.collection('kids');
  final user = FirebaseAuth.instance.currentUser!;
  //List<Kids>? names;

  @override
  void initState() {
    // TODO: implement initState
    KidsNotifier kidsNotifier =
        Provider.of<KidsNotifier>(context, listen: false);
    getKids(kidsNotifier);
    super.initState();
  }

  final List<String> items = <String>["طفل", "طفلة"];
  String? value;
  DateTime? date;

  final _nameController = TextEditingController();

  void _showDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              text,
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("حسناً"),
              )
            ],
          );
        });
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
        );
  }

  void _validate() {
    if (_nameController.text.isEmpty || value == null || date == null) {
      _showDialog("ادخل البيانات المطلوبة");
      //myLoop(names);
    } else {
      addKidDetails();
      showToastMessage("تمت إضافة الطفل بنجاح");

      Notifications.showNotification(
        title: "sarah",
        body: 'hey',
        payload: 'earnily',
      );

      /*
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return KidsjoinviaQRcode_screen_1(); //QrCreateScreen("اضافة طفل");
          },
        ),
      );*/
    } // push,
  }

  Future addKidDetails() async {
    await kidsDb.add({
      'name': _nameController.text,
      'gender': value,
      'date': date,
    });
  }

  void _showDatePicker() async => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2007),
        lastDate: DateTime.now(),
      ).then((value) {
        if (value == null) {
          return;
        }
        setState(() {
          date = value;
        });
      });

  void myLoop(List<Kids> list) {
    for (var i = 0; i < list.length; i++) {
      print(list[i].name);
      print(_nameController.toString());
      if (_nameController.toString() == list[i].name) {
        _showDialog("ممنوع إدخال معلومات مكررة");
      }
      //showToastMessage(list[i].name);
    }
  }

  @override
  Widget build(BuildContext context) {
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context);
    List<Kids> names = kidsNotifier.kidsList;
    myLoop(names);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: new Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "إضافة طفل",
              //textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.01, 20, 0),
                child: Column(
                  children: <Widget>[
                    Container(),
                    SizedBox(height: 30),
                    Icon(
                      Icons.child_care,
                      color: Colors.purple.shade100,
                      size: 100,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "الاسم",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    reuasbleTextField(
                        "الاسم ", Icons.person, false, _nameController),
                    //myLoop(names),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        " الجنس",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                        right: 107,
                        top: 300,
                        width: 254,
                        height: 66,
                        child: Container(
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30),
                              border: const Border(
                                left: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                right: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                top: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                bottom: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
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
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        " تاريخ الميلاد",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                        right: 107,
                        top: 425,
                        child: SizedBox(
                          width: 350,
                          height: 66,
                          child: ElevatedButton(
                              onPressed: _showDatePicker,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: Text(
                                date == null
                                    ? 'اختر تاريخ الميلاد'
                                    : '${DateFormat.yMd().format(date!)}',
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                                textDirection: ui.TextDirection.rtl,
                              )),
                        )),
                    SizedBox(
                      height: 60,
                    ),
                    Positioned(
                        left: 21,
                        top: 625,
                        width: 350,
                        height: 66,
                        child: SizedBox(
                            width: 347,
                            height: 68,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
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
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ))),
                  ],
                ))),
      ),
    );
  }
}
