import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/FirstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  User user;
  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    child: Image(
                      image: AssetImage('images/klipartz.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('userInfo')
                          .doc('userinfo')
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var document = snapshot.data;
                          return Text(
                            "${document.data()['username']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('userInfo')
                          .doc('userinfo')
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var document = snapshot.data;
                          return Text(
                            "${document.data()['email id']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    ));
  }
}
