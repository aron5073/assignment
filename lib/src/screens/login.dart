import 'package:assignment/src/screens/database.dart';
import 'package:assignment/src/screens/home.dart';
import 'package:assignment/src/screens/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 180,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email Address',
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                  ),
                  child: Text('SignIn'),
                  onPressed: () => _signin(_email, _password)
                  //  {
                  //   auth
                  //       .signInWithEmailAndPassword(
                  //           email: _email, password: _password)
                  //       .then((_) => {
                  //             Navigator.of(context)
                  //                 .pushReplacement(MaterialPageRoute(
                  //               builder: (context) => HomeScreen(),
                  //             ))
                  //           });
                  // },
                  ),
              ElevatedButton(
                  child: Text('SignUp'),
                  onPressed: () => _signup(_email, _password)
                  // {
                  //   auth
                  //       .createUserWithEmailAndPassword(
                  //           email: _email, password: _password)
                  //       .then((_) => {
                  //             Navigator.of(context)
                  //                 .pushReplacement(MaterialPageRoute(
                  //               builder: (context) => VerifyScreen(),
                  //             ))
                  //           });
                  // },
                  ),
            ],
          )
        ],
      ),
    );
  }

  //catching errors
  _signin(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);

      //success in signing in
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
    }
  }

  _signup(String _email, String _password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      //hum yaha nya document banyenge user ka uid ka sath
      userSetup('date', 'description', 0, 0,
          0); //date ,description, credit ,debit ,balance
      //creating dummy data here
      //success in signing in

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => VerifyScreen()));
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
    }
  }
}
