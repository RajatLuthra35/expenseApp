import 'package:expense_app/Screens/SecondScreen.dart';
import 'package:expense_app/Screens/tabs-screen.dart';
import 'package:expense_app/services/backend.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final bool isLoading;

  const LoginScreen({Key key, this.isLoading}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 203, 128, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.0,
            ),
            RichText(
              text: TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Save More',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent[700]),
                    )
                  ]),
            ),
            Text(
              'Know your Daily Expenses & Save Money',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 150,
              child: Image(
                image: AssetImage('images/startpageimage.jpg'),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 10,
                    bottom: MediaQuery.of(context).size.width / 20,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _emailcontroller,
                              key: ValueKey('email'),
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Please enter valid email id';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Email Address'),
                            ),
                            TextFormField(
                              controller: _passwordcontroller,
                              key: ValueKey('password'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 7) {
                                  return 'Password must be atleast 7 characters long';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            RaisedButton(
                              child: Text('Login'),
                              onPressed: () async {
                                bool shouldNavigate = await signIn(
                                    _emailcontroller.text,
                                    _passwordcontroller.text);
                                if (shouldNavigate) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TabsScreen(),
                                    ),
                                  );
                                }
                              },
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondScreen()));
                              },
                              child: Text(
                                'Create new account',
                                style: TextStyle(
                                  color: Colors.deepOrange[400],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
