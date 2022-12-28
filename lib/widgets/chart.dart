import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionVals {
    return List.generate(7, (index) {
      //yo function is run 7 times with values of index from 0to6
      final weekDay = DateTime.now().subtract(Duration(
          days: index)); //generates today-0day, today-1day, today-2days...

      double totalSumForWeekDay = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        //finds transactions for a particular weekday and adds the total sum to the weekday
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSumForWeekDay += recentTransactions[i].amount;
        }
      }
      return {
        //a map of
        'day': DateFormat.E().format(weekDay).substring(0, 1), //string: object
        'amount': totalSumForWeekDay
      };
    });
  }

  double get EntireWeekSpending {
    return groupedTransactionVals.fold(0.0, (cumulativeVal, item) {
      return cumulativeVal + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('...hehehe...gotcha!!...');

    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: groupedTransactionVals.map((element) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      (element['day'] as String),
                      (element['amount'] as double),
                      EntireWeekSpending == 0.0
                          ? 0.0
                          : (element['amount'] as double) / EntireWeekSpending),
                );
              }).toList()),
        ));
  }
}
