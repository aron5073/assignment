import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

//will create the document for the particular user

Map data;

class crudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> showData(Map<String, dynamic> userData) {
    FirebaseFirestore.instance
        .collection('expenseTracker')
        .add(userData)
        .catchError((e) {
      print(e);
    });
  }
}

Future<void> userSetup(
    String date, String description, int credit, int debit, int balance) async {
  print('inside the database file');

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();

  Map<String, dynamic> demoData = {
    'date': date,
    'description': description,
    'credit': credit,
    'debit': debit,
    'balance': balance,
    'uid': uid,
  };

  CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('expenseTracker');

  expenseCollection.add(demoData);

  return;
}

fetchData() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance
      .collection('expenseTracker')
      .doc(firebaseUser.uid)
      .get()
      .then((DocumentSnapshot) => {
            print(DocumentSnapshot.data()),
            print(firebaseUser.uid),
          });
}

// Future<void> showData(userData) async {

//   // debugPrint(type);
//   // debugPrint(amount);
//   // debugPrint(expensedescription);
// }
