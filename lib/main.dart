import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hisaab_kitaab/widgets/chart.dart';
import 'package:hisaab_kitaab/widgets/new_transaction.dart';
import 'package:hisaab_kitaab/widgets/transaction_list.dart';
import 'package:intl/intl.dart';

import 'model/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hisab kitab",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransaction {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String name, double cost, DateTime dateTime) {
    final newtx = Transaction(
        id: DateTime.now().toString(), item: name, price: cost, date: dateTime);
    setState(() {
      _transactions.add(newtx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget myAppbar = Platform.isIOS? CupertinoNavigationBar(
      middle: Text("Hisab Kitab"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
         GestureDetector(
           child: Icon(CupertinoIcons.add
           , ),
           onTap:()=> _startAddNewTransaction(context),
         )
        ],
      ),
    ): AppBar(
      title: Text("Hisab Kitab"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => {_startAddNewTransaction(context)},
        )
      ],
    );

    final body = SafeArea( child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height -
                myAppbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
                0.3,
            child: Chart(_recentTransaction),
          ),
          TransactionList(_transactions, _deleteTransaction),
        ],
      ),),
    );

    return Platform.isIOS ? CupertinoPageScaffold(
    navigationBar: myAppbar,
      child: body,
    ) :Scaffold(
      appBar: myAppbar,
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => {_startAddNewTransaction(context)},
          child: Icon(Icons.add)),
    );
  }
}
