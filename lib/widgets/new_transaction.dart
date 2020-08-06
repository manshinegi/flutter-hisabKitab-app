import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<StatefulWidget> createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final item = _itemController.text;
    final price = double.parse(_priceController.text);
    if (_selectedDate == null) {
      return;
    }
    widget.addtx(item, price, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        _selectedDate = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Item",
            ),
            controller: _itemController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Price",
            ),
            controller: _priceController,
            keyboardType: TextInputType.number,
          ),
          Container(
            child: Row(
              children: [
                Text(
                  _selectedDate == null
                      ? "No date choosen."
                      : DateFormat.yMd().format(_selectedDate),
                ),
                FlatButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    "Choose Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Colors.purple,
                )
              ],
            ),
          ),
          Container(
            height: 70,
            child: RaisedButton(
              onPressed: _submitData,
              child: Text("Add Transcation"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
          )
        ],
      ),
    ));
  }
}
