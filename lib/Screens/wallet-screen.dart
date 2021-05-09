import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/services/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController _salarycontroller = new TextEditingController();
  TextEditingController _updatedsalarycontroller = new TextEditingController();
  TextEditingController _oldsalarycontroller = new TextEditingController();
  final formkey = GlobalKey<FormState>();

  void showdialogbox(DocumentSnapshot ds) {
    TextEditingController _salarycontroller = new TextEditingController();
    final formkey = GlobalKey<FormState>();
    String salaryamount;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: formkey,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _salarycontroller,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Salary',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This cant be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                onPressed: () async {
                  await salary(_salarycontroller.text);

                  Navigator.pop(context);
                },
                child: Text('ADD'),
              )
            ],
          );
        });
  }

  void showdialogbox1(DocumentSnapshot ds) {
    TextEditingController _updatedsalarycontroller =
        new TextEditingController();
    TextEditingController _oldsalarycontroller = new TextEditingController();

    final formkey = GlobalKey<FormState>();
    String salaryamount;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: formkey,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _updatedsalarycontroller,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Salary',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This cant be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                onPressed: () async {
                  await salary(_updatedsalarycontroller.text);

                  Navigator.pop(context);
                },
                child: Text('ADD'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Salary')
                  .doc('usersalary')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var document = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        "Salary : ${document.data()['Fixedsalary']}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Salary')
                  .doc('usersalary')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var document = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        "Balance : ${document.data()['Balance']}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Salary')
                  .doc('usersalary')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var document = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        "Money Spent : ${document.data()['spent']}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            onPressed: () => showdialogbox(null),
            child: Text('Input Salary'),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            onPressed: () => showdialogbox1(null),
            child: Text('Update Salary'),
          ),
        ],
      ),
    );
  }
}
