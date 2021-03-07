import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

// class DatabaseServices {
//   final String uid;
//   DatabaseServices(
//       {this.uid}); //making a constructor to get current user databse

//   //giving collection reference
//   final CollectionReference expenseCollection = FirebaseFirestore.instance
//       .collection(
//           'expenseTracker'); //here we are creating a table of name expenseTracker
//   //if it doesnot exists it will create one if exists the take refrence of that

//   Future updateUserData(String date, String description, int credit, int debit,
//       int balance) async {
//         //it will create a document of that user in the collection expenseTracker

//     return await expenseCollection.doc(uid).set({//setData is changed to set and document is changed to doc
//       'date':date,
//       'description':description,
//       'credit' :credit,
//       'debit':debit,
//       'balance':balance,
//     });
//   }
// }
