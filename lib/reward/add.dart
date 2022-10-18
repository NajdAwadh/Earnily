// ignore_for_file: camel_case_types, library_private_types_in_public_api
/*
import 'dart:io';
/*
import 'package:earnily/api/kidtaskApi.dart';
import 'package:earnily/models/kids.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:earnily/screen/profile_screen.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'dart:ui';

import '../api/kidsApi.dart';
import '../notifications/notification_api.dart';
import '../notifier/kidsNotifier.dart';
//import 'kidsjoinviaQRcode_screen_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

*/

import 'package:earnily/models/task.dart';
import 'package:earnily/notifications/notification_api.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../api/kidsApi.dart';
import '../notifier/kidsNotifier.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  @override
List<String> _savedPoint=[];
 //final List<String> list = <String>['سعد', 'ريما', 'خالد'];
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _nameController = TextEditingController();
  String categoty = "";
  String childName = "";
  String points = '';

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
              Navigator.of(context).pop();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  SizedBox(height: 40,),
                  imgWidget("assets/images/gold-star.png", 100, 100),
                   SizedBox(height: 40,),
                    //photo uplode
                Center(
                child: Stack(
                  children: [
                    file == null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("assets/images/EarnilyLogo.png"),
                    )
                  : CircleAvatar(
                      radius: 80,
                     // backgroundImage: AssetImage("assets/images/gold-star.jpg"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                    child: Image.network(
                      imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                    Positioned.fill(
                      child: InkWell(
                    onTap: () {
                      showPicker(
                        context,
                        onGalleryTap: () {
                          getImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        onCameraTap: () {
                          getImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Center(
                            child: Icon(
                              Icons.photo_library_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
          
        ),
                ]
      )
            )
          ),
        ),
      ),
    );

    }
    
  ImagePicker picker = ImagePicker();

  File? file;
  String imageUrl = "";

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 30);
    if (pickedFile != null && pickedFile.path != null) {
      loadingTrue();

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
      loadingTrue() {
    isLoading = true;
    setState(() {});
  }

  loadingFalse() {
    isLoading = false;
    setState(() {});
  }
}*/