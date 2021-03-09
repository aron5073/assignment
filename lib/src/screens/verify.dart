import 'dart:async';

import 'package:assignment/src/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user; //it is changed from auth user to User user in recent update
  Timer timer;

  @override
  void dispose() {
    //agar hamra niche emailverify vale usme nhi gya toh usse hum idhar cancel karenge
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification(); //it will send an email to firebase and check in behalf of us

    //jab bhi hum timer.periodic use karenge toh hume isse open nhi chodna isse ik variable meh dallo aur jab task complete ho jaye udda do

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      //this function will check my email and user have to wait for 5 seconds
      checkEmailVerified();
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 8,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'an email has been sent to ${user.email} please verify ',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload(); //it will refresh the user if signed in
    if (user.emailVerified) {
      timer.cancel(); //here we are canceling the timer which we had setup
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
