import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));


      var totalSum = 0.0;

      for(var trans in transactions){
        if(trans.date.day == weekDay.day
            && trans.date.month == weekDay.month
            && trans.date.year == weekDay.year){
          totalSum += trans.amount;
        }
      }
      return {
        'day':DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalAmount{
    return groupedTransactionValues.fold(0.0, (sum, element) => sum += (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((dayData){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                dayData['day'].toString(),
                dayData['amount'] as double,
                totalAmount == 0.0? 0.0 : (dayData['amount'] as double)/ totalAmount
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
