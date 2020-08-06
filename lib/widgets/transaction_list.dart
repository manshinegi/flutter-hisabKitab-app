import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hisaab_kitaab/model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: transactions.isEmpty
            ? Container(
          height: 200,
          child: Column(
            children: [
              Text("List is empty !!!"),
              Image.asset("images/empty.png"),
            ],
          ),
        )
            : ListView.builder(
                  itemBuilder: (ctx, index) {
            return ListTile(
                leading: CircleAvatar(
                radius: 30,
                child: Padding(
                padding: EdgeInsets.all(10),
            child: FittedBox(
            child: Text(
            '\$${transactions[index].price.toString()}',
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            ),
            ),
            ),
            ),
            ),
            title: Text(
            transactions[index].item,
            style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            ),
            ),
            subtitle: Text(
            DateFormat("yyyy-MM-dd")
                .format(transactions[index].date),
            style: TextStyle(
            color: Colors.grey,
            fontSize: 9,
            )),
            trailing: IconButton(icon : Icon(Icons.delete),
              color: Colors.red, onPressed:()=> deleteTransaction(transactions[index].id),),
            );
          },
          itemCount: transactions.length,
        ));
  }
}

