import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  const AdultsKidProfile({super.key});

  @override
  State<AdultsKidProfile> createState() => _AdultsKidProfile();
}

final user = FirebaseAuth.instance.currentUser!;
bool isLoading = false;
String image = '';
DateTime? date;

class _AdultsKidProfile extends State<AdultsKidProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  bool isEnabled = false;
  @override
  void initState() {
    // TODO: implement initState
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
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Text(
                    'الرمز التعريفي لطفلي',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                  Text(
                    currentKid.pass,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
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
                  NewText(
                    text: ':الاسم',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  //edit
                  /*
                  CustomTextField(
                      controller: nameController,
                      hint: currentKid.name,
                      isEnabled: isEnabled),
                      */
                  NewText(
                    text: currentKid.name,
                    size: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                    height: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewText(
                    text: ':الجنس ',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: new Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentKid.gender,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          imgWidget(set(currentKid.gender), 32, 32),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                    height: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewText(
                    text: ':تاريخ الميلاد',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    /*
                    child: ElevatedButton(
                      onPressed: _showDatePicker,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      */
                    child: new Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${DateFormat.yMd().format(currentKid.date.toDate())}',
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
                    //),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                    height: 5,
                  ),
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
