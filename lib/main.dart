import 'package:earnily/adult_profile.dart';
import 'package:earnily/kid_profile.dart';
import 'package:earnily/reward/add.dart';
import 'package:flutter/material.dart';
//import 'package:qr_flutter/qr_flutter.dart';
//import 'package:qr_generator_tutorial/ui/style/style.dart';
import 'package:earnily/reward/addReward.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      home: addReward(),
     // home: add(),
    // home: kid_profile(),
    //home: adultProfile(),
=======
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      // home: MainPage(),

      //home: HomePage(),
      //home: AddKids_screen_1(),

       //home: MainTask(),
      //home: MainTask(),

      // home: MainTask(),
      // home: QrCreateScreen(),
      // home: kidTasks(),
      //home: kidWish()
      home: HomePageKid(),
>>>>>>> Stashed changes
    );
  }
}
/*
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 238, 248),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              data: data,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            width: 300.0,
            child: TextField(
              //we will generate a new qr code when the input value change
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Type the Data",
                filled: true,
                fillColor: Color.fromARGB(255, 245, 242, 242),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Color.fromARGB(255, 240, 166, 190),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(
              horizontal: 36.0,
              vertical: 16.0,
            ),
            child: Text(
              "Generate QR Code",
            ),
          )
        ],
      ),
    );
  }
}
*/
