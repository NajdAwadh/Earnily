
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../reuasblewidgets.dart';
import '../widgets/new_text.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
bool isLoading = false;
String name = '';
String image = '';
String email = '';
String family = '';
class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isEnabled = false;
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(name);
    print(email);
    _getUserDetail();
  }


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


    void _validate() {
    if (formKey.currentState!.validate()) {
      updateProfile();

      showToastMessage("تمت إضافة نشاط بنجاح");

      Navigator.of(context).pop();
    } else {
      _showDialog();
    }
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
        title: Center(
          child: Text(
            'الملف الشخصي',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),

      body: Scaffold(
            
            backgroundColor: Colors.white,
            body: Form(
                key: formKey,
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                     CircleAvatar(
                      backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/3022/3022000.png"),
                              radius: 100,
                     ),
                              
                        SizedBox(
                          height: 20,
                        ),
                        // GestureDetector(
                        //   onTap: (){
                        //     isEnabled =! isEnabled;
                        //   setState(() {});
                        //     },
                        //   child: Align(
                        //       alignment: Alignment.centerRight,
                        //       child: Text('تعديل',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,color: Colors.black),)),
                              
                        // ),
                              
                        SizedBox(
                          height: 20,
                        ),
                        NewText(
                          text: ':الاسم الاول',
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                              
                         Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? ' الرجاء إدخال اسم ' : null,
                              controller: nameController,
                               enabled: isEnabled,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: name,
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
                        NewText(
                          text: ':العائلة',
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                        
                               Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'الرجاء إدخال عائلة  ' : null,
                              controller: _familyController,
                               enabled: isEnabled,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: family,
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
                        NewText(
                          text: ':البريد الإلكتروني',
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                    
                            Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'الرجاء إدخال بريد الكتروني ' : null,
                              controller: _emailController,
                               enabled: isEnabled,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: email,
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
                          height: 25,
                        ),
                        if (isEnabled == false)
                          NewButton(
                              text: 'تعديل',
                              height: 100,
                              width: 320,
                              onClick: () {
                                isEnabled = !isEnabled;
                                setState(() {});
                              }),
                        if (isEnabled == true)
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'حفظ التغييرات',
                              onClick: () {
                                resetEmail(_emailController.text);
                                updateProfile();
                                
                              }),
                        if (isEnabled == true)
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'إلغاء',
                              onClick: () {
                                   Navigator.of(context).pop();  })
                      ],
                    ),
                  ),
                ),
              ),
            )),
      
    );
  }
  // ImagePicker picker = ImagePicker();
  // File? file;
  // String imageUrl = "";
  // Future getImage(ImageSource source) async {
  //   final pickedFile = await picker.getImage(source: source, imageQuality: 30);
  //   if (pickedFile != null && pickedFile.path != null) {
  //     file = File(pickedFile.path);
  //     setState(() {});
  //     // ignore: use_build_context_synchronously
  //     imageUrl = await UploadFileServices().getUrl(context, file: file!);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
  //   }
  // }
  Future resetEmail(String newEmail) async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('error');
      } else {
        try {
          FirebaseAuth.instance.currentUser!.updateEmail(_emailController.text);
          // print('emailChanged');
        } catch (e) {
          // print('2weeeeewwe${e.toString()}');
        }
      }
    });
  }
  _getUserDetail() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      nameController.text = snapshot.get("firstName");
      image = snapshot.get('image');
      _familyController.text = snapshot.get("family");
      _emailController.text = snapshot.get("email");
      setState(() {});
    });
  }
  updateProfile() {
    if (formKey.currentState!.validate() && nameController.text.isNotEmpty && _familyController.text.isNotEmpty && _emailController.text.isNotEmpty){
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": nameController.text,
        "family":
             _familyController.text,
        "email":  _emailController.text
      }, SetOptions(merge: true)).then((value) {
        print('update');
      });
      setState(() {
      });
      showToastMessage("تمت تعديل نشاط بنجاح");
      // Notifications.showNotification(
      //   title: "EARNILY",
      //   body: ' لديك نشاط جديد بأنتظارك',
      //   payload: 'earnily',
      // );
      Navigator.of(context).pop();
    } else {
      _showDialog();
    }
  }
    }
    

