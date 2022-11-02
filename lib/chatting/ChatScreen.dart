import 'dart:io';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/addKids/adultsKidProfile.dart';
import 'package:earnily/chatting/chatScreenKid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late User signedInUser;
final firebase = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
String childName = '';
String name = '';
String userName = '';
List<String> list = [];
String uid = '';
String myId = '';

void getCurrentUser() {
  try {
    final user = auth.currentUser;
    if (user != null) {
      signedInUser = user;
      myId = signedInUser.uid;
      print(signedInUser.uid);
    }
  } catch (e) {
    print('failed to log in');
  }
}

/*
void kidsStream() async {
  await for (var snapshot in firebase
      .collection('users')
      .doc(signedInUser.uid)
      .collection('kids')
      .snapshots()) {
    for (var kid in snapshot.docs) {
      //print(kid.data());
      list.add(kid.get('name'));
    }
    for (var i = 0; i < list.length; i++) {
      print(list[i]);
    }
  }
}
*/
Future<List<String>> lstKids() async {
  final user = FirebaseAuth.instance.currentUser!;

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('kids')
      .where(name)
      .get();

  List<String> _kidsNamesList = [];

  for (var i = 0; i < snapshot.docs.length; i++) {
    Map<String, dynamic> document =
        snapshot.docs[i].data() as Map<String, dynamic>;

    String name = document['name'];
    _kidsNamesList.add(name);
  }

  return _kidsNamesList;
}

/*
getKidsDetails() {
  firebase
      .collection('kids')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .snapshots()
      .listen((DocumentSnapshot snapshot) {
    uid = snapshot.get('uid');
    myId = snapshot.get('parentId');
    name = snapshot.get('name');
    print('getKid' + myId);
    print(snapshot.get('name'));
  });
}
*/
class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String messageText;
  final TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void validate() {
    messageController.clear();
    addMessages();
  }

  void _showDialog(String text) {
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
              text,
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

  Future addMessages() async {
    print(signedInUser.email);
    final user = await auth.currentUser!;
    if (childName != '') {
      await firebase
          //.collection('users')
          //.doc(signedInUser.uid)
          .collection(childName + ' messages')
          .doc(messageText)
          .set({
        'text': messageText,
        'sender': signedInUser.email,
        'asignedKid': childName,
        'id': myId,
        'time': FieldValue.serverTimestamp(),
        //'uid': firebaseUser.uid,
      });

      messageStream();
      print(user.uid);
      print(signedInUser.uid);
      print(messageText);
    } else {
      _showDialog("قم يإختيار طفل محدد");
      messageController.clear();
    }
  }

  void messageStream() async {
    await for (var snapshot in firebase
        //.collection('users')
        //.doc(signedInUser.uid)
        .collection(childName + ' messages')
        .snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(signedInUser.uid);
    print('kids');
    print(name);
    print('child id:' + myId);
    print(list);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(
            'محادثة',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: new Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(),
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
                  child: FutureBuilder(
                    future: lstKids(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.data);

                        return DropdownButtonFormField<String>(
                            hint: childName.isEmpty
                                ? Text("اختر الطفل")
                                : Text(childName),
                            isExpanded: true,
                            alignment: Alignment.centerRight,
                            // validator: (val) {
                            //   if (val == null) return "اختر الطفل";
                            //   return null;
                            // },
                            items: snapshot.data?.map((valueItem) {
                              return DropdownMenuItem(
                                alignment: Alignment.centerRight,
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                childName = newVal!;
                              });
                            });
                      } else {
                        return SizedBox(
                          height: 10,
                        );
                      }
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              messageStreamBuilder(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'أكتب الرسالة',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: validate,
                      child: Text(
                        'إرسال',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({this.text, this.sender, required this.isMe, Key? key})
      : super(key: key);

  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',
              style: TextStyle(fontSize: 11, color: Colors.black45)),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            //elevation: 5,
            color: isMe ? Colors.blue : Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class messageStreamBuilder extends StatelessWidget {
  const messageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    Iterable<QueryDocumentSnapshot<Object?>> messages = [];
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            // .collection('users')
            //.doc(signedInUser.uid)
            .collection(childName + ' messages')
            .orderBy('time')
            .snapshots(),
        builder: ((context, snapshot) {
          List<MessageWidget> textWidgets = [];
          if (name != childName) {
            print('name ' + name + ' childName' + childName);
          }
          if (!snapshot.hasData) {
            print('no messages');
            ConnectionState == ConnectionState.waiting;
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            String text = message.data().toString().contains('text')
                ? message.get('text')
                : '';
            String sender = message.data().toString().contains('sender')
                ? message.get('sender')
                : '';
            //String id = message.get('id');
            String? currentUser = signedInUser.email;

            print('end:' + sender);
            print(signedInUser);

            final textWidget = MessageWidget(
              sender: sender,
              text: text,
              isMe: currentUser == sender,
            );

            textWidgets.add(textWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: textWidgets,
            ),
          );
        }));
  }
}
