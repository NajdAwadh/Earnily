import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:ui' as ui;

import '../reuasblewidgets.dart';

final List<String> list = <String>['سعد', 'ريما', 'خالد'];
final List<String> category = <String>['النظافة', 'تطوير الشخصيه', 'الدين'];

class NewTask extends StatefulWidget {
  final Function addTx;

  NewTask(this.addTx);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String dropdownValue = list.first;
  String dropdownValue2 = category.first;

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              "ادخل البيانات المطلوبة",
              textAlign: TextAlign.right,
            ),
          );
        });
  }

  Future addKidDetails() async {
    await FirebaseFirestore.instance.collection('Tasks').add({
      'title': _titleController.text,
      'amount': _amountController.text,
    });
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'اسم النشاط'),
              textDirection: ui.TextDirection.rtl,

              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  DropdownButton(
                    value: dropdownValue,
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {});
                    },
                  ),
                  //here
                  Expanded(
                    child: Text(':الطفل', style: TextStyle(fontSize: 25)),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  DropdownButton(
                    value: dropdownValue2,
                    // onChanged: (String value) {
                    // This is called when the user selects an item.
                    //    setState(() {

                    //      });
                    //    },
                    items:
                        category.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {});
                    },
                  ),
                  //here
                  Expanded(
                    child: Text(
                      ':فئة النشاط',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'عدد النقاط المستحقة'),
              textDirection: ui.TextDirection.rtl,
              controller: _amountController,
              keyboardType: TextInputType.number,

              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            //  reuasbleTextField("الاسم ", Icons.person, false, _amountController),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      textDirection: ui.TextDirection.rtl,
                      _selectedDate == null
                          ? '! لم يتم اختيار تاريخ'
                          : 'Due Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  ElevatedButton(
                    // textColor: Theme.of(context).primaryColor,
                    child: Text('اختر تاريخ'),

                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: _presentDatePicker,
                  ),
                  //here
                ],
              ),
            ),
            ElevatedButton(
              child: Text('إضافة نشاط',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple)),
              onPressed: (() {
                if (_titleController.text.isEmpty ||
                    _amountController.text.isEmpty) {
                  _showDialog();
                } else {
                  addKidDetails();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
