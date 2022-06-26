import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.addTransaction})
      : super(key: key);
  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = int.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: const InputDecoration(
            label: Text('使用目的'),
          ),
          controller: titleController,
          onSubmitted: (_) => submitData(),
        ),
        TextField(
          decoration: const InputDecoration(
            label: Text('金額'),
          ),
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onSubmitted: (_) => submitData(),
        ),
        TextButton(
          onPressed: submitData,
          child: const Text('登録'),
        )
      ],
    );
  }
}
