import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  late Color _bgColor;

  @override
  void initState() {
    const availableColor = [
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.red,
    ];

    _bgColor = availableColor[Random().nextInt(availableColor.length)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: FittedBox(
            child: Text('\$${widget.transaction.amount}'),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
            DateFormat.yMMMMd().format(widget.transaction.date)),
        trailing: (MediaQuery.of(context).size.width > 460)
            ? TextButton.icon(
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).errorColor),
          onPressed: () => widget.deleteTx(widget.transaction.id),
          icon: Icon(
            Icons.delete,
          ),
          label: Text('Delete'),
        )
            : IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ),
      ),
    );
  }
}