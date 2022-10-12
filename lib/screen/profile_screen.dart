
import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
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

import '../reuasblewidgets.dart';
import '../widgets/custom_textfield.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isEnabled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(name);
    print(email);
    _getUserDetail();
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
            child: Text(
              'الملف الشخصي',
              style: TextStyle(fontSize: 40),
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
                  Center(
                    child: Stack(
                      children: [
                        file == null
                            ? CircleAvatar(
                                radius: 60,
                              )
                            : CircleAvatar(
                                radius: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.network(
                                    image,
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

                  Text(
                    name + ' ' + family,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300),
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
                  CustomTextField(
                      controller: nameController,
                      hint: name,
                      isEnabled: isEnabled),
                  SizedBox(
                    height: 10,
                  ),
                  NewText(
                    text: ':العائلة',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  CustomTextField(
                      controller: _familyController,
                      hint: family,
                      isEnabled: isEnabled),
                  SizedBox(
                    height: 10,
                  ),
                  NewText(
                    text: ':البريد الإلكتروني',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  CustomTextField(
                      controller: _emailController,
                      hint: email,
                      isEnabled: isEnabled),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        })
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
      name = snapshot.get("firstName");
      image = snapshot.get('image');
      family = snapshot.get("family");
      email = snapshot.get("email");
      setState(() {});
    });
  }

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
}


/*
import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
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

import '../reuasblewidgets.dart';
import '../widgets/custom_textfield.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isEnabled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(name);
    print(email);
    _getUserDetail();
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
             Navigator.of(context).pop();
           },
         )
       ],
       backgroundColor: Colors.black,
       elevation: 0,
       title: Padding(
         padding: EdgeInsets.fromLTRB(0, 0, 
         child: Directionality(
           textDirection: ui.TextDirection.r
           child: Text(
             'الملف الشخصي',
             style: TextStyle(fontSize: 40),
           ),
         ),
       ),
     ),
     body: LoadingOverlay(
       isLoading: isLoading,
       progressIndicator: ProcessingWidget()
       child: Scaffold(
           appBar: AppBar(
             backgroundColor: Colors.transp
             elevation: 0,
             //  iconTheme: IconThemeData(co
           ),
           backgroundColor: Colors.white,
           body: Padding(
             padding: const EdgeInsets.all(1
             child: Column(
               children: [
                 Center(
                   child: Stack(
                     children: [
                       file == null
                           ? CircleAvatar(
                               radius: 60,
                             )
                           : CircleAvatar(
                               radius: 60,
                               child: ClipRR
                                 borderRadiu
                                 child: Imag
                                   image,
                                   height: 1
                                   width: 10
                                   fit: BoxF
                                 ),
                               ),
                             ),
                       Positioned.fill(
                           child: InkWell(
                         onTap: () {
                           showPicker(
                             context,
                             onGalleryTap: (
                               getImage(Imag
                               Navigator.of(
                             },
                             onCameraTap: ()
                               getImage(Imag
                               Navigator.of(
                             },
                           );
                         },
                         child: Align(
                           alignment: Alignm
                           child: Container(
                             height: 40,
                             width: 40,
                             decoration: Box
                               shape: BoxSha
                               color: Color
                             ),
                             child: Padding(
                               padding: cons
                               child: Center
                                 child: Icon
                                   Icons.pho
                                   size: 20,
                                   color: C
                                 ),
                               ),
                             ),
                           ),
                         ),
                       )),
                     ],
                   ),
                 ),
                 Text(
                   name + ' ' + family,
                   style: TextStyle(fontSize
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 Text(
                   email,
                   style:
                       TextStyle(fontSize: 1
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 // GestureDetector(
                 //   onTap: (){
                 //     isEnabled =! isEnabl
                 //   setState(() {});
                 //     },
                 //   child: Align(
                 //       alignment: Alignme
                 //       child: Text('تعديل
                 // ),
                 SizedBox(
                   height: 20,
                 ),
                 NewText(
                   text: ':الاسم الاول',
                   fontWeight: FontWeight.bo
                   size: 18,
                 ),
                 CustomTextField(
                     controller: nameControl
                     hint: name,
                     isEnabled: isEnabled),
                 SizedBox(
                   height: 10,
                 ),
                 NewText(
                   text: ':العائلة',
                   fontWeight: FontWeight.bo
                   size: 18,
                 ),
                 CustomTextField(
                     controller: _familyCont
                     hint: family,
                     isEnabled: isEnabled),
                 SizedBox(
                   height: 10,
                 ),
                 NewText(
                   text: ':البريد الإلكتروني
                   fontWeight: FontWeight.bo
                   size: 18,
                 ),
                 CustomTextField(
                     controller: _emailContr
                     hint: email,
                     isEnabled: isEnabled),
                 if (isEnabled == false)
                   NewButton(
                       text: 'تعديل',
                       height: 100,
                       width: 320,
                       onClick: () {
                         isEnabled = !isEnab
                         setState(() {});
                       }),
                 if (isEnabled == true)
                   NewButton(
                       height: 100,
                       width: 320,
                       text: 'حفظ التغييرات'
                       onClick: () {
                         resetEmail(_emailCo
                         updateProfile();
                       }),
                 if (isEnabled == true)
                   NewButton(
                       height: 100,
                       width: 320,
                       text: 'إلغاء',
                       onClick: () {
                         Navigator.push(
                             context,
                             MaterialPageRou
                                 builder: (c
                       })
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
   final pickedFile = await picker.getImage(
   if (pickedFile != null && pickedFile.path
     loadingTrue();
     file = File(pickedFile.path);
     setState(() {});
     // ignore: use_build_context_synchronou
     imageUrl = await UploadFileServices().g
     await FirebaseFirestore.instance
         .collection("users")
         .doc(FirebaseAuth.instance.currentU
         .set({"image": imageUrl}, SetOption
   }
 }
 Future resetEmail(String newEmail) async {
   FirebaseAuth.instance.userChanges().liste
     if (user == null) {
       print('error');
     } else {
       try {
         FirebaseAuth.instance.currentUser!.
         // print('emailChanged');
       } catch (e) {
         // print('2weeeeewwe${e.toString()}
       }
     }
   });
 }
 _getUserDetail() {
   FirebaseFirestore.instance
       .collection('users')
       .doc(FirebaseAuth.instance.currentUse
       .snapshots()
       .listen((DocumentSnapshot snapshot) {
     name = snapshot.get("firstName");
     image = snapshot.get('image');
     family = snapshot.get("family");
     email = snapshot.get("email");
     setState(() {});
   });
 }
 updateProfile() {
   loadingTrue();
   try {
     FirebaseFirestore.instance
         .collection('users')
         .doc(FirebaseAuth.instance.currentU
         .set({
       "firstName": nameController.text.isEm
       "family":
           _familyController.text.isEmpty ? 
       "email": _emailController.text.isEmpt
     }, SetOptions(merge: true)).then((value
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
}



*/


/*
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
            child: Text(
              'الملف الشخصي',
              style: TextStyle(fontSize: 40),
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
                  Center(
                    child: Stack(
                      children: [
                        file == null
                            ? CircleAvatar(
                                radius: 60,
                              )
                            : CircleAvatar(
                                radius: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.network(
                                    image,
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

                  Text(
                    name + ' ' + family,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300),
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
                  CustomTextField(
                      controller: nameController,
                      hint: name,
                      isEnabled: isEnabled),
                  SizedBox(
                    height: 10,
                  ),
                  NewText(
                    text: ':العائلة',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  CustomTextField(
                      controller: _familyController,
                      hint: family,
                      isEnabled: isEnabled),
                  SizedBox(
                    height: 10,
                  ),
                  NewText(
                    text: ':البريد الإلكتروني',
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  CustomTextField(
                      controller: _emailController,
                      hint: email,
                      isEnabled: isEnabled),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        })
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
      name = snapshot.get("firstName");
      image = snapshot.get('image');
      family = snapshot.get("family");
      email = snapshot.get("email");
      setState(() {});
    });
  }

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

}*/