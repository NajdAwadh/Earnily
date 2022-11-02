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
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../api/kidsApi.dart';
import '../notifier/kidsNotifier.dart';
import '../reuasblewidgets.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/new_text.dart';
import 'package:intl/intl.dart';

class AdultsKidProfile extends StatefulWidget {
  const AdultsKidProfile({super.key,required this.document, required this.id});
  final Map<String, dynamic> document;
  final String id;

  @override
  State<AdultsKidProfile> createState() => _AdultsKidProfile();
}

final user = FirebaseAuth.instance.currentUser!;


class _AdultsKidProfile extends State<AdultsKidProfile> {
bool isLoading = false;
String image = '';
DateTime? date;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  bool isEnabled = false;
  @override
  void initState() {
    // TODO: implement initState


      TextEditingController nameController = TextEditingController(text: widget.document['name']);
  TextEditingController _familyController = TextEditingController(text: widget.document['name']);
    KidsNotifier kidsNotifier =
        Provider.of<KidsNotifier>(context, listen: false);
    getKids(kidsNotifier);
    super.initState();
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

  Future delete(Kids kid, String msg) async {
    // Navigator.of(context);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(kid.uid)
        .collection("kids")
        .doc(kid.name + "@gmail.com")
        .delete();
    await FirebaseFirestore.instance
        .collection('kids')
        .doc(kid.name + '@gmail.com')
        .delete();

   
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return HomePage();
    }));
    showToastMessage(msg);
  }

  void _showDialog(Kids kid) {
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
              delete(kid, 'تم حذف الطفل');
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

  @override
  Widget build(BuildContext context) {
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context);
    Kids currentKid = kidsNotifier.currentKid;

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
              //  iconTheme: IconThemeData(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  children: [
                    Text(
                      'الرمز التعريفي لطفلي',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    Text(
                      currentKid.pass,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'الاسم للتسجيل',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple),
                    ),
                    Text(
                      currentKid.name,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("اسم الطفل:",
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
                        enabled: false,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: currentKid.name,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('الجنس:',
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
                        enabled: false,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: currentKid.gender,
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
                            hintText:
                                '${DateFormat.yMd().format(currentKid.date.toDate())}',
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

                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      iconSize: 40,
                      onPressed: () {
                        _showDialog(currentKid);
                      },
                    ),
                    // NewText(
                    //   text: ':تاريخ الميلاد',
                    //   fontWeight: FontWeight.bold,
                    //   size: 18,
                    // ),
                    // SizedBox(
                    //   width: 300,
                    //   height: 50,
                    //   /*
                    //   child: ElevatedButton(
                    //     onPressed: _showDatePicker,
                    //     style: ElevatedButton.styleFrom(
                    //       padding: EdgeInsets.zero,
                    //       backgroundColor: Colors.grey[200],
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //         side: const BorderSide(
                    //           width: 1,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //     ),
                    //     */
                    //   child: new Directionality(
                    //     textDirection: ui.TextDirection.rtl,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           '${DateFormat.yMd().format(currentKid.date.toDate())}',
                    //           overflow: TextOverflow.visible,
                    //           textAlign: TextAlign.left,
                    //           style: const TextStyle(
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.w400,
                    //             color: Colors.grey,
                    //           ),
                    //         ),
                    //         Icon(
                    //           Icons.calendar_today,
                    //           size: 30,
                    //           color: Colors.black,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   //),
                    // ),
                    // Divider(
                    //   color: Colors.grey[300],
                    //   thickness: 2,
                    //   height: 5,
                    // ),
                    /*
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
                            //resetEmail(_emailController.text);
                            //updateProfile();
                          }),
                    if (isEnabled == true)
                      NewButton(
                          height: 100,
                          width: 320,
                          text: 'إلغاء',
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdultsKidProfile()));
                          })
                          */
                  ],
                ),
              ),
            )),
      ),
    );
  }

  ImagePicker picker = ImagePicker();

  File? file;
  String imageUrl = "";

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 30);
    if (pickedFile != null && pickedFile.path != null) {
      //loadingTrue();

      file = File(pickedFile.path);
      setState(() {});
      // ignore: use_build_context_synchronously
      imageUrl = await UploadFileServices().getUrl(context, file: file!);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
    }
  }
/*
  updateProfile() {
    loadingTrue();
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": nameController.text.isEmpty ? name : nameController.text,
        "family":
            _familyController.text.isEmpty ? family : _familyController.text,
        "email": _emailController.text.isEmpty ? email : _emailController.text
      }, SetOptions(merge: true)).then((value) {
        loadingFalse();
        print('update');
      });
    } catch (e) {
      loadingFalse();
    }
  }

  loadingTrue() {
    isLoading = true;
    setState(() {});
  }

  loadingFalse() {
    isLoading = false;
    setState(() {});
  }
  */
}
