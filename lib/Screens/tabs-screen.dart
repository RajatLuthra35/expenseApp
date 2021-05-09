import 'package:expense_app/Screens/expense-screen.dart';
import 'package:expense_app/Screens/wallet-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'FirstScreen.dart';
import 'drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[400],
          title: Text('Daily Expenses'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance_wallet),
                text: 'Amount Left',
              ),
              Tab(
                icon: Icon(Icons.money),
                text: 'Spending Done',
              ),
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                })
          ],
        ),
        body: TabBarView(
          children: [
            WalletScreen(),
            ExpenseScreen(),
          ],
        ),
      ),
    );
  }
}
