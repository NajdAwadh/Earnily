import 'package:earnily/models/task.dart';
import 'package:earnily/notifications/notification_api.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:earnily/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../api/kidsApi.dart';
import '../notifier/kidsNotifier.dart';
//notification
import 'package:earnily/notifications/local_notification_service.dart';
import 'package:earnily/notifications/second_screen.dart';
import 'new_button.dart';

class View_task extends StatefulWidget {
  const View_task({super.key});
  @override
  State<View_task> createState() => _View_taskState();
}

class _View_taskState extends State<View_task> {
  late Task _currentTask;
  @override
  //notification
  late final LocalNotificationService service;
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _selectedDate;
  late final _nameController;
  late String categoty;
  late String childName;
  late String points;
  bool edit = false;

  void initState() {
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    _nameController =
        TextEditingController(text: taskNotifier.currentTask.taskName);
    categoty = taskNotifier.currentTask.category;
    childName = taskNotifier.currentTask.asignedKid;
    points = taskNotifier.currentTask.points;
    _selectedDate = taskNotifier.currentTask.date;
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
  }

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
            TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);

      _updateTask(
        taskNotifier.currentTask.tid, 
        taskNotifier.currentTask.adult,
        taskNotifier.currentTask.asignedKid);
      showToastMessage("تمت إضافة نشاط بنجاح");
      // Notifications.showNotification(
      //   title: "EARNILY",
      //   body: ' لديك نشاط جديد بأنتظارك',
      //   payload: 'earnily',
      // );
      Navigator.of(context).pop();
    } else {
      _showDialog();
    }
  }

  Future _updateTask(String id, String adult, String kid) async {
    //Navigator.of(context).pop();
    
    
    
       if (formKey.currentState!.validate() &&
        categoty != "" &&
        points != "" &&
        _selectedDate != "") {  
         
       await FirebaseFirestore.instance
        .collection('users')
        .doc(adult)
        .collection("Task")
        .doc(id)
        .update({
  'taskName': _nameController.text,
      'points': points,
      'date': _selectedDate,
      'category': categoty,
      'asignedKid': childName,
    });
    await FirebaseFirestore.instance
        .collection('kids')
        .doc(kid + '@gmail.com')
        .collection("Task")
        .doc(id)
        .update({

    'taskName': _nameController.text,
      'points': points,
      'date': _selectedDate,
      'category': categoty,
      'asignedKid': childName,
    });
      showToastMessage("تمت إضافة نشاط بنجاح");
      // Notifications.showNotification(
      //   title: "EARNILY",
      //   body: ' لديك نشاط جديد بأنتظارك',
      //   payload: 'earnily',
      // );
      Navigator.of(context).pop();
    } else {
      _showDialog();
    }
    
    
    
    
   
  }

  Future updateTaskOld() async {
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('Task')
        .doc(taskNotifier.currentTask.tid)
        .update({
      'taskName': _nameController.text,
      'points': points,
      'date': _selectedDate,
      'category': categoty,
      'asignedKid': childName,
      'state': 0,
    });
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user.uid)
    //     .collection('kids')
    //     .doc('reema')
    //     .collection('Task')
    //     .add({
    //   'taskName': _nameController.text,
    //   'points': points,
    //   'date': _selectedDate,
    //   'category': categoty,
    //   'asignedKid': childName,
    //   'state': 'Not complete',
    //   'tid': tid,
    // });
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
          _selectedDate +
          '\n  نوع النشاط:' +
          categoty,
      // 'asignedKid'+ childName,
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = DateFormat.yMd().format(pickedDate);
      });
    });
  }

  Widget build(BuildContext context) {
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context, listen: false);
    List<String> list = kidsNotifier.kidsNamesList;
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);

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
              Navigator.of(context).pop();
            },
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(
            taskNotifier.currentTask.taskName,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ":اسم النشاط ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     
                      Container(
                        alignment: Alignment.topRight,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          controller: _nameController,
                           enabled: edit,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' اسم النشاط الجديد',
                              hintTextDirection: ui.TextDirection.rtl,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              contentPadding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              )),
                          validator: (val) =>
                              val!.isEmpty ? 'اختر اسم النشاط' : null,
                          //onChanged: (val) => setState(() => _currentName = val),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ":اختر الطفل المخصص للنشاط",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (edit == false)

                              Container(
                        alignment: Alignment.topRight,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          
                          enabled: false,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                         hintText: childName,
                              hintTextDirection: ui.TextDirection.rtl,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              contentPadding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              )),
                      
                        ),
                      ),
                                ],
                        ),
                      ),
                      if (edit == true)
                        Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(245, 245, 245, 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButtonFormField<String>(
                                hint: childName.isEmpty
                                    ? Text("اختر الطفل")
                                    : Text(childName),
                                isExpanded: true,
                                alignment: Alignment.centerRight,
                                // validator: (val) {
                                //   if (val == null) return "اختر الطفل";
                                //   return null;
                                // },
                                items: list.map((valueItem) {
                                  return DropdownMenuItem(
                                    enabled: edit,
                                    alignment: Alignment.centerRight,
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    childName = newVal!;
                                  });
                                })),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ":عدد النقاط المستحقة",
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
                            pointsSelect("100", 0xffff6d6e),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('75', 0xfff29732),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('50', 0xff6557ff),
                            SizedBox(
                              width: 20,
                            ),
                            pointsSelect('25', 0xff2bc8d9),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ":تاريخ التنفيذ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (edit == false)

                            Container(
                        alignment: Alignment.topRight,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          
                          enabled: false,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              border: InputBorder.none,
hintText: _selectedDate,
                              hintTextDirection: ui.TextDirection.rtl,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              contentPadding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              )),
                      
                          //onChanged: (val) => setState(() => _currentName = val),
                        ),
                      ),
                            
                          ],
                        ),
                      ),
                      if (edit == true)
                      SizedBox(
                        //width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _presentDatePicker,
                          style: ElevatedButton.styleFrom(
                         
                            padding: EdgeInsets.all(18),
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            
                            ),
                          ),
                          child: new Directionality(
                            textDirection: ui.TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedDate == ""
                                      ? 'لم يتم اختيار تاريخ'
                                      : 'التاريخ المختار: ${_selectedDate}',
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ":نوع النشاط",
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
                            categorySelect("النظافة", 0xffff6d6e),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('الأكل', 0xfff29732),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('الدراسة', 0xff6557ff),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('الدين', 0xff234ebd),
                            SizedBox(
                              width: 20,
                            ),
                            categorySelect('تطوير الشخصية', 0xff2bc8d9),
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                        
                      
                      Column(children: <Widget>[
                        if (edit == false)
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'تعديل',
                              onClick: () {
                                setState(() {
                                  edit = !edit;
                                });
                              }),
                        if (edit == true)
                            NewButton(
                              height: 100,
                              width: 320,
                              text: 'حفظ التغييرات',
                              onClick: ()=> { _updateTask( taskNotifier.currentTask.tid,
                                        taskNotifier.currentTask.adult,
                                        taskNotifier.currentTask.asignedKid)
                              }),
                    
                        if (edit == true)
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'إلغاء',
                              onClick: () {
                                
                                 Navigator.of(context).pop();
                                
                              }),
                      ]),
                    ],
                  ))),
        ),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? (() {
              setState(() {
                categoty = label;
              });
            })
          : null,
      child: Chip(
   backgroundColor: categoty.isEmpty
            ? Color(color)
            : categoty == label
                ? Color(color)
                : Colors.grey,        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
  color: categoty.isEmpty
                ? Colors.white
                : categoty == label
                    ? Colors.white
                    : Colors.black,            fontSize: 15,
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

  Widget pointsSelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? (() {
              setState(() {
                points = label;
              });
            })
          : null,
      child: Chip(
         backgroundColor: points.isEmpty
            ? Color(color)
            : points == label
                ? Color(color)
                : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
       color: points.isEmpty
                ? Colors.white
                : points == label
                    ? Colors.white
                    : Colors.black,            fontSize: 15,
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

  //notification
  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);
  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}
