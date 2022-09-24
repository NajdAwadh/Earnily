// ignore_for_file: camel_case_types, library_private_types_in_public_api

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

  Widget build(BuildContext context) {
    var value;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          'إضافة مكافأة',
          style: TextStyle(fontSize: 40),
        ),
        actions: [],
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
                   
                   //kid name field
                   Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: TextField(
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
         ],
      ),
    ),
  ),
  ),
  //SizedBox(height: 10),

                );
  }
}