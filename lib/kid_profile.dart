import 'package:flutter/material.dart';

class kid_profile extends StatefulWidget {
  const kid_profile({super.key});

  @override
  State<kid_profile> createState() => _kid_profileState();
}

class _kid_profileState extends State<kid_profile> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
   appBar: AppBar(
     backgroundColor: Colors.deepPurple,
     elevation: 0,
     title: Text(
       ' صفحتي الشخصية',
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

          //photo field
          /*
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              children: [
              CircleAvatar(
                backgroundImage: AssetImage("assest/profileIcon.png"),
                  ),
              ],
            ),
          ),
          */


          Text("الاسم" , style: TextStyle(fontSize:20 ),),
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
                 labelText: "الاسم",
                 hintText:"نجد",
                 fillColor: Colors.grey[200],
                 filled: true,
               ),
             ),
             ),
              
              SizedBox(height: 10),


              Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25.0),

  child: TextField(
   // controller: _emailController,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      labelText: "الاسم",
      hintText:"نجد",
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
     );
  }
}