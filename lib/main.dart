import 'package:earnily/addKids/adultKids.dart';
import 'package:earnily/onbording.dart';
import 'package:earnily/pages/KidTasks.dart';
import 'package:earnily/pages/home_page_kid.dart';
import 'package:earnily/pages/kidWishs.dart';
import 'package:earnily/pages/main_page.dart';
import 'package:earnily/screen/QRreader.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:earnily/widgets/MainTask.dart';
import 'package:earnily/widgets/add_task.dart';

//import 'package:earnily/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:qr_generator_tutorial/ui/style/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'notifier/kidsNotifier.dart';
import 'notifier/taskNotifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return TaskNotifier();
      },
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return KidsNotifier();
      },
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      //home: MainPage(),
      // home: MainTask(),
      //home: MainTask(),
      // home: MainTask(),
      // home: QrCreateScreen(),
      // home: HomePageKid(),
      //home: kidTasks(),
      //home: kidWish()
      home: HomePageKid(),
    );
  }
}

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
