import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({required this.transactions, required this.deleteTx});

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return (transactions.isEmpty)
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transaction added',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
            },
            itemCount: transactions.length,
          );
  }
}


