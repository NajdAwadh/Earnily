import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/addKids/adultsKidProfile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  //late User signedInUser;
  late String messageText;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //getCurrentUser();
  }
/*
  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  */

  void validate() {
    addMessages();
  }

  Future addMessages() async {
    final user = await auth.currentUser!;
    await firebase.collection('messages').add({
      'text': messageText,
      'sender': user.email,
      'id': user.uid,
      //'uid': firebaseUser.uid,
    });
    print(user.uid);
    print(messageText);
    messageStream();
  }

  void messageStream() async {
    await for (var snapshot in firebase.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            //Image.asset('images/logo.png', height: 25),
            SizedBox(width: 10),
            Text('MessageMe')
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: firebase.collection('messages').snapshots(),
                builder: ((context, snapshot) {
                  List<Text> textWidgets = [];
                  if (!snapshot.hasData) {
                    //add spinner
                    print('null');
                  }

                  final messages = snapshot.data!.docs;
                  for (var message in messages) {
                    String text = message.get('text');
                    String sender = message.get('sender');
                    String id = message.get('id');
                    final textWidget = Text('$text - $sender');
                    textWidgets.add(textWidget);
                  }

                  return Column(
                    children: textWidgets,
                  );
                })),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
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
                      'send',
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
    );
  }
}
