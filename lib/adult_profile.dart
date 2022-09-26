import 'package:flutter/material.dart';

class adultProfile extends StatefulWidget {
  const adultProfile({super.key});

  @override
  State<adultProfile> createState() => _adultProfileState();
}

class _adultProfileState extends State<adultProfile> {
  bool isObscurePassword= true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.deepPurple,
  elevation: 0,
  title: Text(
    ' صفحتي الشخصية',
    style: TextStyle(fontSize: 40)
    ),
     ),

     body: Container(
      padding: EdgeInsets.only(left: 15, top: 20 , right: 15 ),
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Center(
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
                          'https://static.vecteezy.com/system/resources/previews/002/318/271/original/user-profile-icon-free-vector.jpg'
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
            SizedBox(height: 30),
            buildTextField("الاسم" , "نجد", false),
            buildTextField("البريد الالكتروني" , "najd@gmail.com", false),
            buildTextField("كلمة المرور" , "******", true),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                   child: Text("الغاء",
                   style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2,
                    color: Colors.black
                   ),),
                   style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                   ),
                   ),
                   ElevatedButton(
                    onPressed: () {},
                    child: Text("حفظ" , style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2 ,
                      color: Colors.white
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    )
              ],
            )

          ],
        ),
         ),
        ),



    );

  }
  
  Widget buildTextField(String labelText , String placeholder , bool isPasswordTextField) {
    return  Padding(
      padding: EdgeInsets.only(bottom: 30 ),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword :false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField ?
          IconButton(
            icon: Icon(Icons.remove_red_eye , color: Colors.grey,),
            onPressed: () {}
           ): null,
           contentPadding: EdgeInsets.only(bottom: 5),
           labelText: labelText,
           floatingLabelBehavior: FloatingLabelBehavior.always,
           hintText: placeholder,
           hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
           )
        ),
      ),
      );
  }
}