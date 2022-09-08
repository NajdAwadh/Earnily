import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//ll

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("firebase"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => FirebaseFirestore.instance
              .collection('testing')
              .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('testing').snapshots(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                // final docData = snapshot.data?.docs[index].data();
                var timestamp = 'timestamp';
                // final dataTime = (docData!['${timestamp}'] as Timestamp).toDate();
                return ListTile(
                  title: Text(timestamp.toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}