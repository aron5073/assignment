import 'package:flutter/material.dart';
import 'package:assignment/src/screens/database.dart';

class addTranscation extends StatefulWidget {
  @override
  _addTranscationState createState() => _addTranscationState();
}

class _addTranscationState extends State<addTranscation> {
  static var _transcationtype = ['credit', 'debit'];
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //making varibales which pass values to another page
  String _valueSelectedByUser = 'debit';
  String _amountValue = '';
  String _descriptionValue = '';

  crudMethods crudObj = new crudMethods();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transcation'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: [
            //Transcation type
            ListTile(
              title: DropdownButton(
                items: _transcationtype.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                style: textStyle,
                value: 'debit',
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    if (valueSelectedByUser == 'debit')
                      valueSelectedByUser = 'credit';
                    else
                      valueSelectedByUser = 'debit';
                    debugPrint(
                        'transcation type selected $valueSelectedByUser');
                    _valueSelectedByUser = valueSelectedByUser;
                  });
                },
              ),
            ),

            //writing code for amount section
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                style: textStyle,
                onChanged: (amountValue) {
                  setState(() {
                    debugPrint(
                        'something changed in amount box   $amountValue');
                    _amountValue = amountValue;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),

            //writing code for the amount description box

            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (descriptionValue) {
                  setState(() {
                    debugPrint(
                        'something changed in description box $descriptionValue ');
                    _descriptionValue = descriptionValue;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),

            //making buttons to save or cancel
            Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Map<String, dynamic> userData = {
                          'amountValue': _amountValue,
                          'descriptionValue': _descriptionValue,
                          'valueSelectedByUser': _valueSelectedByUser
                        };
                        crudObj.showData(userData).then((result) {
                          dialogTrigger(context);
                        }).catchError((e) {
                          print(e);
                        });
                        // setState(() {
                        //   debugPrint('changes done in save button');
                        //   // showData(_valueSelectedByUser, _amountValue,
                        //   //     _descriptionValue);

                        // });
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('changes done in delete button ');
                          _amountValue = '0';
                          _descriptionValue = '';

                          amountController.clear();
                          descriptionController.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> dialogTrigger(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'job done',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
        content: Text('Added'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('alright')),
        ],
      );
    },
  );
}
