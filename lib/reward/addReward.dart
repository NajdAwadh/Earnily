// ignore_for_file: camel_case_types, library_private_types_in_public_api

//import 'package:earnily/widgets/add_task.dart';
/*
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                //photo uplode
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
}*/