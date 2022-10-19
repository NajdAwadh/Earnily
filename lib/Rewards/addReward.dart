// ignore_for_file: camel_case_types, library_private_types_in_public_api
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:earnily/services/upload_file.dart';
import 'package:earnily/widgets/new_button.dart';
import 'package:earnily/widgets/processing_widget.dart';
import 'package:earnily/widgets/show_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../reuasblewidgets.dart';
import '../widgets/show_picker.dart';
import 'dart:ui' as ui;

class add_Reward extends StatefulWidget {
  const add_Reward({super.key});

  @override
  State<add_Reward> createState() => _addRewardState();
}
/*
bool isLoading = false;
String name = '';
String image = '';
String email = '';
String family = '';
*/
class _addRewardState extends State<add_Reward> {
  @override
 late List<String>_savedPoint=['250','500','750','1000'];
 //text controlllers
 final _nameController = TextEditingController();
// bool isEnabled = false;
 String points = '';
//final List<String> list = <String>['سعد', 'ريما', 'خالد'];
 
 final _formKey = GlobalKey<FormState>();
 GlobalKey<FormState> formKey = GlobalKey<FormState>();



//final user = FirebaseAuth.instance.currentUser!;

Future retrieve() async {
DocumentReference docRef= FirebaseFirestore.instance.collection('points').doc('points');
DocumentSnapshot doc = await docRef.get();
 List<String>_savedPoint =doc.data() as List<String>;
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
       //categoty != "" &&
       points != ""
       //_selectedDate != ""
       ) {
     addTask();
     showToastMessage("تمت إضافة مكافاة بنجاح");
     Navigator.of(context).pop();
   } else {
     _showDialog();
   }
 }
 Future addTask() async {
   //const tuid = Uuid();
   //String tid = tuid.v4();
   await FirebaseFirestore.instance
      // .collection('users')
       //.doc(user.uid)
       .collection('reward')
       .add({
     'rewardName': _nameController.text,
     'points': points,
     'image':"assets/images/gold-star.png",
   });
   retrieve();
 }

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
                    //validateReturn(true);
                    Navigator.of(context).pop();
                  },
                )
              ],
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              "إضافة مكافاة",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),

backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        //child: SafeArea(
          child:Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:Image.network(
                      "assets/images/gold-star.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    ),
                    ),
                  SizedBox(height: 40,),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            ":اسم المكافأة ",
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
                                hintText: ' اسم المكافاة ',
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
                                val!.isEmpty ? 'اختر اسم المكافاة ' : null,
                            //onChanged: (val) => setState(() => _currentName = val),
                          ),
                        ),
                      SizedBox(height: 20),

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
                            
                            pointsSelect(_savedPoint[3], 0xffff6d6e),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect(_savedPoint[2], 0xfff29732),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect(_savedPoint[1], 0xff6557ff),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect(_savedPoint[0 ], 0xff2bc8d9),
                          ]),
                        SizedBox(height: 80,),
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
                              ),
                  ),
            )
            )
          )
        );
  }

  /*
  ImagePicker picker = ImagePicker();
  File? file;
  String imageUrl = "";

Future getImage(ImageSource source) async {
  final pickedFile = await picker.pickImage(source: source );
  if (pickedFile != null && pickedFile.path != null) {
    loadingTrue();
    file = File(pickedFile.path);
    setState(() {});
    // ignore: use_build_context_synchronously
    imageUrl = await UploadFileServices().getUrl(context, file: file!);
    //await FirebaseFirestore.instance
        //.collection("users")
        //.doc(user.uid)
        //.collection('reward')
        //.doc(FirebaseAuth.instance.currentUser!.uid)
       // .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
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
//point
Widget pointsSelect(String label, int color) {
  return InkWell(
    onTap: (() {
      setState(() {
        points = label;
      });
    }),
    child: Chip(
      backgroundColor: points == label ? Colors.white : Color(color),
     // onPressed: () => setState(() => pressAttention = !pressAttention),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: points == label ? Colors.black : Colors.white,
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
}