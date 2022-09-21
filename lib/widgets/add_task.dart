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
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();

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
    //to do
    await FirebaseFirestore.instance.collection('kids').add({
      'name': _nameController.text,
      'gender': value,
      'date': date,
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  void _showDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(2007),
      lastDate: DateTime(2023),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          ' إضافة نشاط جديد',
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ":اسم النشاط ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' اسم النشاط الجديد',
                            hintTextDirection: ui.TextDirection.rtl,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            )),
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a name' : null,
                        //onChanged: (val) => setState(() => _currentName = val),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ":اختر الطفل المخصص للنشاط",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<String>(
                            isExpanded: true,
                            alignment: Alignment.centerRight,
                            hint: const Text(
                              " اسم الطفل",
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.right,
                            ),
                            value: value,
                            items: list.map((valueItem) {
                              return DropdownMenuItem(
                                alignment: Alignment.centerRight,
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                value = newVal!;
                              });
                            })),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ":عدد النقاط المستحقة",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 10,
                        children: [
                          chipData("100", 0xffff6d6e),
                          SizedBox(
                            width: 20,
                          ),
                          chipData('75', 0xfff29732),
                          SizedBox(
                            width: 20,
                          ),
                          chipData('50', 0xff6557ff),
                          SizedBox(
                            width: 20,
                          ),
                          chipData('25', 0xff2bc8d9),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ":تاريخ التنفيذ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              textDirection: ui.TextDirection.rtl,
                              _selectedDate == null
                                  ? '! لم يتم اختيار تاريخ'
                                  : 'التاريخ المختار: ${DateFormat.yMd().format(_selectedDate)}',
                            ),
                          ),

                          IconButton(
                              onPressed: _presentDatePicker,
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              icon: Icon(
                                Icons.calendar_today,
                                //  size: 30,
                              ))
                          //here
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ":نوع النشاط",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 10,
                        children: [
                          chipData("النظافة", 0xffff6d6e),
                          SizedBox(
                            width: 20,
                          ),
                          chipData('الأكل', 0xfff29732),
                          SizedBox(
                            width: 20,
                          ),
                          chipData('الدراسة', 0xff6557ff),
                          SizedBox(
                            width: 20,
                          ),
                          chipData('الدين', 0xff234ebd),
                          SizedBox(
                            width: 20,
                          ),
                          chipData('تطوير الشخصية', 0xff2bc8d9),
                        ]),
                    SizedBox(
                      height: 30,
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

Widget chipData(String label, int color) {
  return Chip(
    backgroundColor: Color(color),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
    labelPadding: EdgeInsets.symmetric(
      horizontal: 17,
      vertical: 3.5,
    ),
  );
}
