import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/addKids/adultsKidProfile.dart';
import 'package:earnily/chatting/ChatScreenKid.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis/clouddebugger/v2.dart';
import 'package:googleapis/compute/v1.dart';
import 'package:provider/provider.dart';

import '../api/kidsApi.dart';
import '../models/kids.dart';
import '../notifier/kidsNotifier.dart';

late User signedInUser;
String childName = '';
String name = '';
List<String> list = [];
//List<String> uidList = [];
String uid = '';
String myId = '';

class ChatScreenKid extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreenKid({Key? key}) : super(key: key);

  @override
  _ChatScreenKidState createState() => _ChatScreenKidState();
}

class _ChatScreenKidState extends State<ChatScreenKid> {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  late String messageText;
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        signedInUser = user;
        childName = user.email!.substring(0, user.email!.indexOf('@'));
        myId = signedInUser.uid;
        print(signedInUser);
      }
    } catch (e) {
      print('fail to log in');
    }
  }

  void validate() {
    messageController.clear();
    addMessages();
  }

  Future addMessages() async {
    print(signedInUser.email);
    final user = await auth.currentUser!;

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
                      onPressed:
                          validate, //addMessages(messageText, signedInUser),
                      /* {
                      final firebaseUser = FirebaseAuth.instance.currentUser!;
                      FirebaseFirestore.instance
                          .collection('messages')
                          .doc(firebaseUser.uid)
                          .set({'text': messageText, 'sender': signedInUser});
                    },*/
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
          if (!snapshot.hasData) {
            print('no messages');
            ConnectionState == ConnectionState.waiting;
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (name != childName) {
            print('name' + name + 'childName' + childName);
          }

          messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            String text = message.get('text');
            String sender = message.get('sender');
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
