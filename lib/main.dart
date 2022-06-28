import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Record',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              titleSmall: const TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              bodySmall: const TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              titleTextStyle: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: const MyHomePage(),
      localizationsDelegates:const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  // 1週間以内のトランザクションを取得
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, int amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(addTransaction: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Record'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Chart(recentTransactions: _recentTransaction),
              Expanded(child: TransactionList(transactions: _userTransactions)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
