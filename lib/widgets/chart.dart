import 'package:flutter/material.dart';
import 'package:hisaab_kitaab/model/Transaction.dart';
import 'package:hisaab_kitaab/widgets/bar.dart';
import 'package:hisaab_kitaab/widgets/transaction_list.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum = totalSum + transactions[i].price;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    });
  }

  double get maxSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((tx) {
            return Flexible(
                fit: FlexFit.tight,
                child: Bar(
                    tx['day'],
                    tx["amount"],
                    maxSpending == 0.0
                        ? 0.0
                        : (tx["amount"] as double) / maxSpending));
          }).toList(),
        ),
      )
    );
  }
}
