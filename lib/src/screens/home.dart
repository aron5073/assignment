import 'package:assignment/src/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Expense Tracker',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              // fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  // fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              onPressed: () => {
                auth.signOut(),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                )),
              },
            ),
          ]),

      // body: Center(
      //   child: TextButton(
      //     child: Text('Logout'),
      //     onPressed: () => {
      //       auth.signOut(),
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //         builder: (context) => LoginScreen(),
      //       )),
      //     },
      //   ),
      // ),
    );
  }
}
