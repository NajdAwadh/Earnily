
import 'package:earnily/reuasblewidgets.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

//import 'kidsjoinviaQRcode_screen_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? value;

class Add_task extends StatefulWidget {
  const Add_task({super.key});

  @override
  State<Add_task> createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {
  @override
final List<String> list = <String>['سعد', 'ريما', 'خالد'];
final List<String> category = <String>['النظافة', 'تطوير الشخصيه', 'الدين'];

String? value;
  DateTime? date;



  final _nameController = TextEditingController();
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
      firstDate: DateTime(2007),
      lastDate: DateTime(2021),
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





  Widget build(BuildContext context) {

 double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          'إضافة نشاط',
          style: TextStyle(fontSize: 40),
        ),
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(
                  children: <Widget>[
                    Container(),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ":اسم النشاط ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    reuasbleTextField(
                        ":اسمه النشاط  ", Icons.add, false, _nameController),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        " :الطفل",
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
                                items: list.map((valueItem) {
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
                        " :الفئة",
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
                                items: list.map((valueItem) {
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
                                backgroundColor: Colors.deepPurple,
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