import 'package:earnily/reuasblewidgets.dart';
import 'package:flutter/material.dart';

class kid_profile extends StatefulWidget {
  const kid_profile({super.key});

  @override
  State<kid_profile> createState() => _kid_profileState();
}

class _kid_profileState extends State<kid_profile> {
   final TextEditingController _emailController = TextEditingController();
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
   body: Container(
      child: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height * 0.01, 20, 0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "البريد الإلكتروني",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
                    ),
                    ),
                    reuasbleTextField("example@email.com", Icons.email, false, _emailController),
                    SizedBox(
                      height: 20,)
                      ],
        ),
        ),

      )
      ),
      );
  }
}