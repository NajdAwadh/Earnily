import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../pages/login_page.dart';
import '../pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  void toggleScreens(){

    setState(() {
      showLoginpage=!showLoginpage;
    });

  }
  @override
  //intially,show the login page
  bool showLoginpage=true;
  @override
  Widget build(BuildContext context) {
    if(showLoginpage){
    return LoginPage(showRegisterpage: toggleScreens);
    }else{
    return RegisterPage(showLoginpage: toggleScreens);
    }
  }
}