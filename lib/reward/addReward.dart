// ignore_for_file: camel_case_types, library_private_types_in_public_api

//import 'package:earnily/widgets/add_task.dart';

import 'package:flutter/material.dart';

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