import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

//will create the document for the particular user

Map data;

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

showData(var type, var amount, var expensedescription) {
  var url = Uri.https(
      'https://expense-tracker-63ceb-default-rtdb.firebaseio.com/',
      '/expenseCollection.json');
  http.post(url,
      body: json.encode({
        'date': DateTime.now().toString(),
        'description': expensedescription,
        'amount': amount,
      }));

  debugPrint(type);
  debugPrint(amount);
  debugPrint(expensedescription);
}
