import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
    final VoidCallback showRegisterpage;
  const LoginPage({
    Key? key,
    required this.showRegisterpage
  }):super(key:key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   //text controlllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose(){
    _emailController.dispose();
   _passwordController.dispose();
    super.dispose();
  }

  Future signin() async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 backgroundColor: Colors.grey[300],
      body: SafeArea(
        child:Center(
           child: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 //logo
                 Icon(
                   Icons.apple,
                   size: 100,
                 ), //icon
                 SizedBox(height: 75),

                 //اهلاٍ بك
                 Text(
                   'سجل دخولك',
                   style: GoogleFonts.bebasNeue(
                     fontSize: 52,
                   ),
                 ),
                 SizedBox(height: 10),
                 Text(
                   '',
                   style:TextStyle(
                     fontSize: 18,
                   ),
                 ),
            
                 SizedBox(height: 50),

                 //email field
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: TextField(
                     controller: _emailController,
                     decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.white),
                         borderRadius: BorderRadius.circular(12),
                       ),
                       hintText: 'الايميل',
                       fillColor: Colors.grey[200],
                       filled: true,
                     ),
                   ),
                 
                   ),
                   SizedBox(height: 10),

                   //password
                    Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: TextField(
                     controller: _passwordController,
                     decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.white),
                         borderRadius: BorderRadius.circular(12),
                       ),
                       hintText: 'الرقم السري',
                       fillColor: Colors.grey[200],
                       filled: true,
                     ),
                   ),
                 
                   ),
                   SizedBox(height: 10),

                   //sign up button

                    Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: GestureDetector(
                    onTap: signin,
                    child: Container(
                      padding: EdgeInsets.all(20),
                     decoration: BoxDecoration(
                       color: Colors.deepPurple,
                         borderRadius: BorderRadius.circular(12),
                       ),
                       child: Center(
                         child: Text(
                           'سجل',
                           style:TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                           ),
                         ),
                       ),
                    ),
                   ),
                    ),

                 //aleardy a member? sign in
     Row(           
mainAxisAlignment:MainAxisAlignment.center,
children: [
Text(
'ليس لديك عائلة؟ ',
style:TextStyle(
fontWeight: FontWeight.bold,
), 
),

GestureDetector(
onTap: widget.showRegisterpage,
child: Text(
' سجل الان',
style: TextStyle(
color: Colors.blue,
fontWeight: FontWeight. bold,
),
),
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