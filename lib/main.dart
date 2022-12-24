// ignore_for_file: avoid_unnecessary_containers, depend_on_referenced_packages

import 'package:expenses/widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
                //deafult ThemeData.light() object ko textTheme member lai copyWith user-defined params, copyWith is a TextTheme returning function

                headline6: const TextStyle(
              fontFamily: 'Solway',
              fontSize: 20,
            )),
        primarySwatch: Colors.teal,
        fontFamily: 'Solway',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Solway',
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String? inputTitle;

  //list that stores user's transactions
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'Crocs', amount: 12.65, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Taco', amount: 12.33, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'Sphagetti', amount: 5.45, date: DateTime.now()),
  ];

  //*****************see this entanglement(1)******************
  //receives title and amount from modalsheet and forms a transaction object to add to _usertransactions list

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime txChosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txChosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(
          newTx); //this is going to cause a change in display, so inside setstate
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id ==
            id; //for whichever element this test function returns true, the element is removed
      });
    });
  }

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //this is to be triggered onpress of action button

  //*****************see this entanglement(1)******************
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        //provided by flutter this function
        context: ctx,
        builder: (_) {
          return NewTransaction(
              _addNewTransaction); //TODO: this is from new_transactions.dart skip this and come back after done with understanding transaction_list.dart
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          //the plus button at the top right
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        //handles notches and all
        child: SingleChildScrollView(
          //makes the body i.e everything below the appbar scrollable,check on a browser or desktop app and resize to see effect
          child: Column(
            //basically the wrapper for the entire body
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card(
              //   color: Colors.grey,
              //   elevation: 5,
              //   child: Container(
              //       alignment: Alignment.center,
              //       width: 120,
              //       height: 300,
              //       child: const Text('CHART')),
              // ),
              Chart(recentTransactions),
              TransactionList(_userTransactions,
                  _deleteTransaction) //constructing a custom widget object from transaction_list by passing the list of transactions
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(
              context)), //triggers the showing of bottommodalsheet
    );
  }
}
