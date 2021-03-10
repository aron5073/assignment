import 'package:assignment/src/screens/add_transcation.dart';
import 'package:assignment/src/screens/database.dart';
import 'package:assignment/src/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuerySnapshot showndata;
  crudMethods crudObj = new crudMethods();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    crudObj.getData().then((result) {
      setState(() {
        showndata = result;
      });
    });
    super.initState();
  }

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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.black,
        onPressed: () {
          //it will fetch all the collection data
          fetchData();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return addTranscation();
          }));
          //form will appear up for making changes in the database
        },
        icon: Icon(Icons.add),
        label: Text('Add Transcation'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _userList(),
    );
  }

  Widget _userList() {
    if (showndata != null) {
      return ListView.builder(
        itemCount: showndata.docs.length,
        padding: EdgeInsets.all(15.0),
        itemBuilder: (context, i) {
          return new ListTile(
            title: Text('Transcation type : ' +
                showndata.docs[i].data()['valueSelectedByUser']),
            subtitle:
                Text('Amount : ' + showndata.docs[i].data()['amountValue']),
            leading: Text(showndata.docs[i].data()['day'] +
                '/' +
                showndata.docs[i].data()['month'] +
                '/' +
                showndata.docs[i].data()['year']),
            trailing: Text('Balance'),
          );
        },
      );
    } else {
      return Text('loading text');
    }
  }
}
