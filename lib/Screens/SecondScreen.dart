import 'package:expense_app/Screens/tabs-screen.dart';
import 'package:expense_app/services/backend.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final bool isLoading;

  const SecondScreen({Key key, this.isLoading}) : super(key: key);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _emailcontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();
  TextEditingController _usernamecontroller = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var isLogin = true;
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
                              key: ValueKey('email'),
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Please enter valid email id';
                                }
                                return null;
                              },
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Email Address'),
                            ),
                            TextFormField(
                              controller: _usernamecontroller,
                              key: ValueKey('username'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 4) {
                                  return 'please enter at least 4 characters';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Username'),
                            ),
                            TextFormField(
                              key: ValueKey('password'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 7) {
                                  return 'Password must be atleast 7 characters long';
                                }
                                return null;
                              },
                              controller: _passwordcontroller,
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            RaisedButton(
                              child: Text('Register'),
                              onPressed: () async {
                                bool shouldNavigate = await signUp(
                                    _emailcontroller.text,
                                    _passwordcontroller.text);
                                if (shouldNavigate) {
                                  intialsalary('0');
                                  userInfo(_usernamecontroller.text,
                                      _emailcontroller.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TabsScreen(),
                                    ),
                                  );
                                }
                              },
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
