// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:earnily/api/kidtaskApi.dart';
import 'package:earnily/models/task.dart';
import 'package:earnily/notifications/notification_api.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../api/kidsApi.dart';
import '../notifier/kidsNotifier.dart';

//notification
import 'package:earnily/notifications/local_notification_service.dart';
import 'package:earnily/notifications/second_screen.dart';

import '../notifier/taskNotifier.dart';
import '../pages/home_page.dart';

class Add_task extends StatefulWidget {
  const Add_task({super.key});

  @override
  State<Add_task> createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {
  @override
  //notification
  late final LocalNotificationService service;
  void initState() {
    super.initState();
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();

    getTask(Provider.of<TaskNotifier>(context, listen: false));
    getKidsNames(Provider.of<KidsNotifier>(context, listen: false));
  }

  //final List<String> list = <String>['سعد', 'ريما', 'خالد'];
  final user = FirebaseAuth.instance.currentUser!;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _selectedDate = "";
  final _nameController = TextEditingController();
  String categoty = "";
  String childName = "";
  String points = '';
  int count = 0;

  void _showDialog() {
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
              "ادخل البيانات المطلوبة",
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

  void _showDialogCancel() {
    showDialog(
      //barrierDismissible = false;
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "لحظة",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'هل انت متأكد من إلغاء العملية ؟',
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) {
                    return count++ == 2;
                  },
                );
              },
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("البقاء"),
            )
          ],
        );
      },
    );
  }

  void showToastMessage(String message) {
    //raghad
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white,

        //message text color

        fontSize: 16.0 //message font size
        );
  }

  void _validate() {
    if (formKey.currentState!.validate() &&
        categoty != "" &&
        points != "" &&
        _selectedDate != "") {
      addTask();

      showToastMessage("تمت إضافة نشاط بنجاح");

      /* Notifications.showNotification(
        title: "EARNILY",
        body: ' لديك نشاط جديد بأنتظارك',
        payload: 'earnily',
      );*/

      Navigator.of(context).pop();
    } else {
      _showDialog();
    }
  }

  Future addTask() async {
    const tuid = Uuid();
    String tid = tuid.v4();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('Task')
        .doc(tid)
        .set({
      'taskName': _nameController.text,
      'points': points,
      'date': _selectedDate,
      'category': categoty,
      'asignedKid': childName,
      'state': 'Not complete',
      'tid': tid,
      'adult': user.uid,
    });

    await FirebaseFirestore.instance
        .collection('kids')
        .doc(childName + '@gmail.com')
        .collection('Task')
        .doc(tid)
        .set({
      'taskName': _nameController.text,
      'points': points,
      'date': _selectedDate,
      'category': categoty,
      'asignedKid': childName,
      'state': 'Not complete',
      'tid': tid,
      'adult': user.uid,
    });
    //notification
    /*await service.showNotificationWithPayload(
      id: 1,
      title: 'تمت اضافة نشاط جديد',
      body: 'اسم النشاط:' + _nameController.text,
      payload: 'اسم النشاط:' +
          _nameController.text +
          '\n  النقاط:' +
          points +
          '\n  تاريخ التنفيذ:' +
          _selectedDate +
          '\n  نوع النشاط:' +
          categoty,
      // 'asignedKid'+ childName,
    );*/
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
        _selectedDate = DateFormat.yMd().format(pickedDate);
      });
    });
  }
/*
  void initState() {
    // TODO: implement initState
    KidsNotifier kidsNotifier =
        Provider.of<KidsNotifier>(context, listen: false);
    getKids(kidsNotifier);
    getKidsNames(kidsNotifier);

    super.initState();
  }*/
  // final List<String> list = <String>[kidsNotifier.kidsList[index].name,];

  Widget build(BuildContext context) {
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context);
    List<String> list = kidsNotifier.kidsNamesList;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              _showDialogCancel();
            },
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(
            'إضافة نشاط',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
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
                          controller: _nameController,

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
                              val!.isEmpty ? 'اختر اسم النشاط' : null,
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
                          child: DropdownButtonFormField<String>(
                              hint: childName.isEmpty
                                  ? Text("اختر الطفل")
                                  : Text(childName),
                              isExpanded: true,
                              alignment: Alignment.centerRight,
                              validator: (val) {
                                if (val == null) return "اختر الطفل";
                                return null;
                              },
                              items: list.map((valueItem) {
                                return DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  childName = newVal!;
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
                            pointsSelect("١٠٠", 0xffff6d6e),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('٧٥', 0xfff29732),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('٥٠', 0xff6557ff),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('٢٥', 0xff2bc8d9),
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
                      /*
                      Container(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                textDirection: ui.TextDirection.rtl,
                                _selectedDate == ""
                                    ? 'لم يتم اختيار تاريخ'
                                    : 'التاريخ المختار: ${_selectedDate}',
                              ),
                            ),

                            IconButton(
                                onPressed: _presentDatePicker,
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                icon: Icon(
                                  Icons.calendar_today,
                                  //  size: 30,
                                ))
                            //here
                          ],
                        ),
                      ),
                      */

                      SizedBox(
                        //width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _presentDatePicker,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(18),
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: new Directionality(
                            textDirection: ui.TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedDate == ""
                                      ? 'لم يتم اختيار تاريخ'
                                      : 'التاريخ المختار: ${_selectedDate}',
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
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
                            categorySelect("النظافة", 0xffff6d6e),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('الأكل', 0xfff29732),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('الدراسة', 0xff6557ff),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('الدين', 0xff234ebd),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('تطوير الشخصية', 0xff2bc8d9),
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
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: (() {
        setState(() {
          categoty = label;
        });
      }),
      child: Chip(
        // backgroundColor: categoty == label ? Color(color) : Colors.grey,
        backgroundColor: categoty.isEmpty
            ? Color(color)
            : categoty == label
                ? Color(color)
                : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: categoty.isEmpty
                ? Colors.white
                : categoty == label
                    ? Colors.white
                    : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.5,
        ),
      ),
    );
  }

  Widget pointsSelect(String label, int color) {
    return InkWell(
      onTap: (() {
        setState(() {
          points = label;
        });
      }),
      child: Chip(
        backgroundColor: points.isEmpty
            ? Color(color)
            : points == label
                ? Color(color)
                : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: points.isEmpty
                ? Colors.white
                : points == label
                    ? Colors.white
                    : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.5,
        ),
      ),
    );
  }

  //notification
  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);
  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}
