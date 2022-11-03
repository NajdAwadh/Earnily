import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/addKids/adultKids.dart';
import 'package:earnily/models/kids.dart';
import 'package:earnily/pages/home_page.dart';
import 'package:earnily/services/upload_file.dart';
import 'package:earnily/widgets/new_button.dart';
import 'package:earnily/widgets/processing_widget.dart';
import 'package:earnily/widgets/show_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googleapis/people/v1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../reuasblewidgets.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/new_text.dart';
import 'package:intl/intl.dart';

class AdultsKidProfile extends StatefulWidget {
  const AdultsKidProfile({super.key, required this.document, required this.id});
  final Map<String, dynamic> document;
  final String id;

  @override
  State<AdultsKidProfile> createState() => _AdultsKidProfile();
}

final user = FirebaseAuth.instance.currentUser!;

class _AdultsKidProfile extends State<AdultsKidProfile> {
  bool isLoading = false;
  late String dateastimestamp;
  String? value;
  DateTime? date;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();

  final List<String> items = <String>["طفل", "طفلة"];

  bool isEnabled = false;
  bool edit = false;
  late String pass;

  @override
  void initState() {
    // TODO: implement initState

    _nameController = TextEditingController(text: widget.document['name']);
    value = widget.document['gender'];
    date = widget.document['date'].toDate();
    pass = widget.document['pass'];

    super.initState();
  }

  void _showDatePicker() {
    showDatePicker(
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
        //here maybe an error
      });
    });
  }

  String set(String gender) {
    if (gender == "طفلة")
      return "assets/images/girlIcon.png";
    else
      return "assets/images/boy24.png";
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

  Future delete(String kiduid, String kidName, String msg) async {
    // Navigator.of(context);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(kiduid)
        .collection("kids")
        .doc(kidName + "@gmail.com")
        .delete();
    await FirebaseFirestore.instance
        .collection('kids')
        .doc(kidName + '@gmail.com')
        .delete();

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return HomePage();
    }));
    showToastMessage(msg);
  }

  void _showDialog(String kiduid, String kidName) {
    showDialog(
        context: context,
        builder: (context) {
          // set up the buttons
          Widget cancelButton = TextButton(
            child: Text(
              "لا",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            onPressed: Navigator.of(context).pop,
          );
          Widget continueButton = TextButton(
            child: Text(
              "نعم",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            onPressed: () {
              delete(kiduid, kidName, 'تم حذف الطفل');
            },
          );

          return AlertDialog(
            title: Text(
              'حذف طفلك',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            content: Text(
              'هل انت متاكد بحذف طفلك؟',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              cancelButton,
              continueButton,
            ],
          );
        });
  }

  Future _updateTask(String adult, String kid) async {
    //Navigator.of(context).pop();
    if (value != "" && _nameController.text != "" && date != "") {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(adult)
          .collection("kids")
          .doc(kid)
          .update({
        'name': _nameController.text,
        'gender': value,
        'date': date,
      });

      await FirebaseFirestore.instance.collection('kids').doc(kid).update({
        'name': _nameController.text,
        'gender': value,
        'date': date,
      });
      showToastMessage("تم تعديل ملف طفلك بنجاح");
      // Notifications.showNotification(
      //   title: "EARNILY",
      //   body: ' لديك نشاط جديد بأنتظارك',
      //   payload: 'earnily',
      // );
      Navigator.of(context).pop();
    } else {
      _showDialog2();
    }
  }

  void _showDialog2() {
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

  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).pop();
            },
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Center(
              child: Text(
                'ملف الطفل',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: ProcessingWidget(),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  children: [
                    if (widget.document['gender'] == 'طفلة' && edit == false)
                      imgWidget("assets/images/girlIcon.png", 100, 100),
                    if (widget.document['gender'] == 'طفل' && edit == false)
                      imgWidget("assets/images/boyIcon.png", 100, 100),
                    Text(
                      'الرمز التعريفي لطفلي',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    Text(
                      widget.document['pass'],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("الاسم:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textDirection: ui.TextDirection.rtl,
                          textAlign: TextAlign.right),
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
                        enabled: edit,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'الاسم',
                            hintTextDirection: ui.TextDirection.rtl,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Text('طفل أم طفلة:',
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold),
                    //       textDirection: ui.TextDirection.rtl,
                    //       textAlign: TextAlign.right),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    if (edit == false)
                      Container(
                          // alignment: Alignment.topRight,
                          // height: 50,
                          // width: MediaQuery.of(context).size.width,
                          // decoration: BoxDecoration(
                          //     color: Colors.grey[100],
                          //     borderRadius: BorderRadius.circular(15)),
                          // child: TextFormField(
                          //   enabled: false,
                          //   textAlign: TextAlign.right,
                          //   decoration: InputDecoration(
                          //       border: InputBorder.none,
                          //       hintText: widget.document['gender'],
                          //       hintTextDirection: ui.TextDirection.rtl,
                          //       hintStyle: TextStyle(
                          //         color: Colors.black,
                          //         fontSize: 17,
                          //       ),
                          //       contentPadding: EdgeInsets.only(
                          //         left: 20,
                          //         right: 20,
                          //       )),
                          // ),
                          ),
                    if (edit == true)
                      Positioned(
                          right: 107,
                          top: 300,
                          width: 254,
                          height: 66,
                          child: Container(
                              alignment: Alignment.topRight,
                              child: new Directionality(
                                  textDirection: ui.TextDirection.rtl,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Row(
                                        //female
                                        children: [
                                          Radio(
                                              value: items[1],
                                              groupValue: value,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  value = newValue!;
                                                });
                                              }),
                                          Text(
                                            items[1],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          imgWidget(
                                              "assets/images/girlIcon.png",
                                              32,
                                              32),
                                        ],
                                      ),
                                      Row(
                                        //male
                                        children: [
                                          Radio(
                                              value: items[0],
                                              groupValue: value,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  value = newValue!;
                                                });
                                              }),
                                          Text(
                                            items[0],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          imgWidget("assets/images/boyIcon.png",
                                              32, 32),
                                        ],
                                      )
                                    ],
                                  )))),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'تاريخ الميلاد:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textDirection: ui.TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (edit == false)
                      Container(
                        alignment: Alignment.topRight,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          enabled: false,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${DateFormat.yMd().format(date!)}',
                              hintTextDirection: ui.TextDirection.rtl,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              contentPadding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              )),

                          //onChanged: (val) => setState(() => _currentName = val),
                        ),
                      ),
                    if (edit == true)
                      SizedBox(
                        //width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _showDatePicker,
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
                                  date == ""
                                      ? 'لم يتم اختيار تاريخ'
                                      : 'التاريخ المختار: ${DateFormat.yMd().format(date!)}',
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
                    Column(children: <Widget>[
                      if (edit == false)
                        NewButton(
                            height: 100,
                            width: 320,
                            text: 'تعديل',
                            onClick: () {
                              setState(() {
                                edit = !edit;
                              });
                            }),
                      if (edit == true)
                        NewButton(
                            height: 100,
                            width: 320,
                            text: 'حفظ التغييرات',
                            onClick: () => {_updateTask(user.uid, widget.id)}),
                      if (edit == true)
                        NewButton(
                            height: 100,
                            width: 320,
                            text: 'إلغاء',
                            onClick: () {
                              Navigator.of(context).pop();
                            }),
                    ]),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      iconSize: 40,
                      onPressed: () {
                        _showDialog(
                            widget.document['uid'], widget.document['name']);
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
