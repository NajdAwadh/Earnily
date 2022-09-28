import 'package:earnily/api/kidsApi.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/MainTask.dart';
import 'addkids_screen_1.dart';

class AdultKids extends StatefulWidget {
  const AdultKids({super.key});

  @override
  State<AdultKids> createState() => _AdultKidsState();
}

class _AdultKidsState extends State<AdultKids> {
  @override
  void initState() {
    // TODO: implement initState
    KidsNotifier kidsNotifier =
        Provider.of<KidsNotifier>(context, listen: false);
    getKids(kidsNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "الأطفال",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Container(
        // ghada
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xffff6d6e),
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Container(
                            height: 33,
                            width: 36,
                            child: Icon(Icons.child_care),
                          )),
                    ),
                    title: Text(
                      kidsNotifier.kidsList[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    subtitle: Text(
                      kidsNotifier.kidsList[index].gender,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => {},
                    ),
                  ),
                ));
          },
          itemCount: kidsNotifier.kidsList.length,
        ),

        /*
            child: 
            ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text("test"),
                  title: Text("test"),
                  //subtitle: Text(kidsNotifier.kidsList[index].gender),
                );
              },
              itemCount: 1, //kidsNotifier.kidsList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black);
              },
            ),*/
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const AddKids_screen_1();
              },
            ),
          );
        },
      ),
    );
  }
}
