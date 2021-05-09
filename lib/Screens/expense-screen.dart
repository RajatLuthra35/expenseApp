import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/services/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  void showdialogbox(DocumentSnapshot ds) {
    TextEditingController _itemcontroller = new TextEditingController();
    TextEditingController _amountcontroller = new TextEditingController();
    TextEditingController _quantitycontroller = new TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: formKey,
              autovalidate: true,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _itemcontroller,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This cant be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _amountcontroller,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This cant be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _quantitycontroller,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
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
                  await addItem(_itemcontroller.text, _amountcontroller.text,
                      _quantitycontroller.text);
                  await totalSum(
                      _amountcontroller.text, _quantitycontroller.text);
                  await moneySpent(
                      _amountcontroller.text, _quantitycontroller.text);
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
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('Items')
                .orderBy('Time')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Card(
                      elevation: 4.0,
                      child: ListTile(
                        leading: Icon(
                          Icons.attach_money,
                          color: Colors.lightGreen,
                        ),
                        title: Text("${document.data()['itemName']}"),
                        trailing: SizedBox(
                            width: 120,
                            child: Text("${document.data()['Amount']}")),
                      ),
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showdialogbox(null),
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
