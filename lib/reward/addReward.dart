// ignore_for_file: camel_case_types, library_private_types_in_public_api

//import 'package:earnily/widgets/add_task.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:earnily/services/upload_file.dart';
import 'package:earnily/widgets/new_button.dart';
import 'package:earnily/widgets/processing_widget.dart';
import 'package:earnily/widgets/show_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../widgets/show_picker.dart';

class add_Reward extends StatefulWidget {
  const add_Reward({super.key});

  @override
  State<add_Reward> createState() => _addRewardState();
}
bool isLoading = false;
String name = '';
String image = '';
String email = '';
String family = '';

class _addRewardState extends State<add_Reward> {
  @override
  //text controlllers
  final _nameController = TextEditingController();
  final _pointController = TextEditingController();
bool isEnabled = false;
String points = '';


/*
 late final LocalNotificationService service;
 void initState() {
   service = LocalNotificationService();
   service.intialize();
   listenToNotification();
   super.initState();
 }
 //final List<String> list = <String>['سعد', 'ريما', 'خالد'];
 final user = FirebaseAuth.instance.currentUser!;
 final _formKey = GlobalKey<FormState>();
 GlobalKey<FormState> formKey = GlobalKey<FormState>();
 DateTime _selectedDate = DateTime.now();
 final _nameController = TextEditingController();
 String categoty = "";
 String childName = "";
 String points = '';
 void _showDialog() {
   showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: Text(
             "خطأ",
             textAlign: TextAlign.right,
             style: TextStyle(color: Colors.red),
           ),
           content: Text(
             "ادخل البيانات المطلوبة",
             textAlign: TextAlign.right,
           ),
           actions: <Widget>[
             TextButton(
               onPressed: Navigator.of(context).pop,
               child: const Text("حسناً"),
             )
           ],
         );
       });
 }
 void showToastMessage(String message) {
   //raghad
   Fluttertoast.showToast(
       msg: message, //message to show toast
       toastLength: Toast.LENGTH_LONG, //duration for message to show
       gravity: ToastGravity.CENTER, //where you want to show, top, bottom
       timeInSecForIosWeb: 1, //for iOS only
       //backgroundColor: Colors.red, //background Color for message
       textColor: Colors.white,
       //message text color
       fontSize: 16.0 //message font size
       );
 }



 void _validate() {
   if (formKey.currentState!.validate() &&
       categoty != "" &&
       points != "" &&
       _selectedDate != "") {
     addTask();
     showToastMessage("تمت إضافة نشاط بنجاح");
     Notifications.showNotification(
       title: "EARNILY",
       body: ' لديك نشاط جديد بأنتظارك',
       payload: 'earnily',
     );
     Navigator.of(context).pop();
   } else {
     _showDialog();
   }
 }

 Future addTask() async {
   const tuid = Uuid();
   String tid = tuid.v4();
   await FirebaseFirestore.instance
       .collection('users')
       .doc(user.uid)
       .collection('Task')
       .add({
     'taskName': _nameController.text,
     'points': points,
     'date': DateFormat.yMd().format(_selectedDate),
     'category': categoty,
     'asignedKid': childName,
     'state': 0,
   });
   await FirebaseFirestore.instance
       .collection('users')
       .doc(user.uid)
       .collection('kids')
       .doc('reema')
       .collection('Task')
       .add({
     'taskName': _nameController.text,
     'points': points,
     'date': DateFormat.yMd().format(_selectedDate),
     'category': categoty,
     'asignedKid': childName,
     'state': 'Not complete',
     'tid': tid,
   });
   //notification
   await service.showNotificationWithPayload(
     id: 1,
     title: 'تمت اضافة نشاط جديد',
     body: 'اسم النشاط:' + _nameController.text,
     payload: 'اسم النشاط:' +
         _nameController.text +
         '\n  النقاط:' +
         points +
         '\n  تاريخ التنفيذ:' +
         DateFormat.yMd().format(_selectedDate) +
         '\n  نوع النشاط:' +
         categoty,
     // 'asignedKid'+ childName,
   );
 }*/



  Widget build(BuildContext context) {
    var value;
    String point2 = "25";


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    //validateReturn(true);
                    Navigator.of(context).pop();
                  },
                )
              ],

        
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              "إضافة مكافأة",
              style: TextStyle(fontSize: 40),
            ),
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
              SizedBox(
                height: 20,
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
                  SizedBox(height: 20),
                    //point field

                    Column(
                      children: [
                        //Text(":نقاط النشاط" , style: TextStyle(fontSize:20 ),),
                        Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ":نقاط النشاط",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 10,
                          children: [
                            pointsSelect("1000", 0xffff6d6e),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('750', 0xfff29732),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('500', 0xff6557ff),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('250', 0xff2bc8d9),
                          ]),


                        /*  CustomRadioButton(
                              elevation: 0,
                              absoluteZeroSpacing: true,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: [
                                '1000',
                                '750',
                                '500',
                                '250',
                              ],
                              buttonValues: [
                                '1000',
                                '750',
                                '500',
                                '250',
                              ],
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Colors.black,
                                  textStyle: TextStyle(fontSize: 16)),
                              radioButtonValue: (value) {
                                print(value);
                              }, selectedColor: Colors.black ,
                            ),*/
                            ],
                          ),
                          SizedBox(height: 40),


                            Positioned(
                              left: 21,
                              top: 625,
                              width: 350,
                              height: 66,
                              child: SizedBox(
                                  width: 347,
                                  height: 68,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            onPressed: (() {
                              //do something
                            }),
                            child: const Text('إضافة ',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w400,
                                )),
                          ))),
                        SizedBox(height: 20),
              ]
              )
          )
        )
      ),
    );
  }
  ImagePicker picker = ImagePicker();
File? file;
String imageUrl = "";

Future getImage(ImageSource source) async {
  final pickedFile = await picker.getImage(source: source, imageQuality: 30);
  if (pickedFile != null && pickedFile.path != null) {
    loadingTrue();
    file = File(pickedFile.path);
    setState(() {});
    // ignore: use_build_context_synchronously
   // imageUrl = await UploadFileServices().getUrl(context, file: file!);
   /* await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
  */
  }
}
loadingTrue() {
  isLoading = true;
  setState(() {});
}
loadingFalse() {
  isLoading = false;
  setState(() {});
}

//point
Widget pointsSelect(String label, int color) {
  return InkWell(
    onTap: (() {
      setState(() {
        points = label;
      });
    }),
    child: Chip(
      backgroundColor: points == label ? Colors.white : Color(color),
     // onPressed: () => setState(() => pressAttention = !pressAttention),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: points == label ? Colors.black : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 3.5,
      ),
    ),
  );
}
}

/*
class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
     ),
     );
    
  }
}*/
/*
 Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
*/
