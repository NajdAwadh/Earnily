// ignore_for_file: camel_case_types, library_private_types_in_public_api

//import 'package:earnily/widgets/add_task.dart';

import 'package:flutter/material.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class addReward extends StatefulWidget {
  const addReward({super.key});

  @override
  State<addReward> createState() => _addRewardState();
}

class _addRewardState extends State<addReward> {
  @override
  //text controlllers
  final _nameController = TextEditingController();
  final _pointController = TextEditingController();
String point = "25";
String point2 = "25";

  Widget build(BuildContext context) {
    var value;
    String point2 = "25";


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
               children: [Center(
  child: Stack(
    children: [
      Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          border: Border.all(width: 4,color: Colors.white ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
            )
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image:NetworkImage(
              'https://static.vecteezy.com/system/resources/previ'
            )
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 40,
          width: 40, 
          decoration: BoxDecoration(
            shape: BoxShape.circle, 
            border: Border.all(
              width: 4,
              color: Colors.white
            ),
            color: Colors.blue
          ),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        )
        )
    ],
    ),
),

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
                   SizedBox(height: 10),
                    
                    //point field
                    /*
                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: TextField(
                    // controller: _emailController,
                     decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.white),
                         borderRadius: BorderRadius.circular(12),
                       ),
                       hintText: 'النقاط',
                       fillColor: Colors.grey[200],
                       filled: true,
                     ),
                   ),
                 
                   ),
                   SizedBox(height: 10),
                   */


                   //kid name field
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
                      hintText: 'اسم الطفل ',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                  SizedBox(height: 10),


                  /*
                   Column(
                    children: [
                      Text(":نقاط النشاط" , style: TextStyle(fontSize:20 ),),

                      RadioListTile(title: Text("25"), value:"25",groupValue: point, onChanged:(value){
                        setState(() {
                          point=value.toString();
                        });
                      },
                     ),
                      RadioListTile(title: Text("50"), value:"50",groupValue: point, onChanged:(value){
                         setState(() {
                           point=value.toString();
                           });
                           },
                           ),
                    ],
                   ), */

                  Column (
                    children: [
                        Text(":نقاط النشاط" , style: TextStyle(fontSize:20 ),),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio(value: 250, groupValue: point2, onChanged:(value) {
                                  setState(() {
                                    point2=value.toString();
                                    });
                                },
                                ),
                                const Expanded(child: Text("250"))
                              ],
                            ),
                            //flex: 1,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio(  value: 500, groupValue: point2, onChanged: (value){
                                    setState(() {
                                      point2=value.toString();
                                      });
                                  },
                                  ),
                                  Expanded(child: Text("500"))
                                ],
                              ),
                              flex:1 ,
                              ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Radio(value: 1000, groupValue: point2, onChanged: (value){
                                          setState(() {
                                            point2=value.toString();
                                          });
                                    } ,
                                                      ),
                              Expanded(child: Text("1000"))
                                          ],
                                          ),
                                          flex:1 ,
                                          ),
                        ],
                        ),

                    ],
                      ),

      ],
      ),
    ),
  ),
  ),

                );
  }
}