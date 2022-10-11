// ignore_for_file: camel_case_types, library_private_types_in_public_api

//import 'package:earnily/widgets/add_task.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

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
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class add_Reward extends StatefulWidget {
  const add_Reward({super.key});

  @override
  State<add_Reward> createState() => _add_RewardState();
}
bool isLoading = false;
String name = '';
String image = '';
class _add_RewardState extends State<add_Reward> {
  @override

  //text controlllers
  final _nameController = TextEditingController();
  final _pointController = TextEditingController();
String point = "25";
String point2 = "25";
final ImagePicker _picker = ImagePicker();

  Widget build(BuildContext context) {
   int _value = 1;
    String point2 = "25";


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
                    //validateReturn(true);
                    Navigator.of(context).pop();
                  },
                )
              ],
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "إضافة مكافأة",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),

backgroundColor: Colors.white,
      body: SafeArea(
        child:Center(
           child: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  //name field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                    textAlign: TextAlign.right,
                    // controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'عنوان المكافأة',
                      fillColor: Colors.grey[200],
                filled: true,

                ),
              ),

              ),
                SizedBox(
                    height: 60,
                  ),

              Column(
              children: [
                Text(":نقاط النشاط" , style: TextStyle(fontSize:20 ),),
                  CustomRadioButton(
                      elevation: 0,
                      absoluteZeroSpacing: true,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables: [
                        '1000',
                        '750',
                        '500',
                        '250',
                      ],
                      buttonValues: [
                        '1000',
                        '750',
                        '500',
                        '250',
                      ],
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: TextStyle(fontSize: 16)),
                      radioButtonValue: (value) {
                        print(value);
                      },
                      selectedColor: Theme.of(context).accentColor,
                    ),

                ],
              ),
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
                    onPressed: (() {
                      //do something
                    }),
                    child: const Text('إضافة ',
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                        )),
                  ))),
            ],
            ),
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
}

/*
class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}*/