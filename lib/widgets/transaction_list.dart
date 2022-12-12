import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;//a list to receive the list of transactions

  final Function deleteTx; //receives deleteTransaction Function from main.dart file
  TransactionList(this.transactions, this.deleteTx); //initializes the list, 'transactions' when instantiated

  @override
  Widget build(BuildContext context) {
    return Container(
      //whatever is to be built is inside the build method, which in this case is a container
      height: 500,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black38, width: 2)),
      child: transactions.isEmpty
          ? Column(
              //show this column when the transactions list is empty
              children: [
                Text('No Transactions Added! ', //the text
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    //and the image
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            )
          : ListView.builder(
              //listview builder object
              itemBuilder: (cntxt, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              'Rs: \n${transactions[index].amount.toStringAsFixed(1)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6, //using headline6 TextStyle from main.dart's textTheme property
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 116, 114, 114),
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.greenAccent.shade100,
                        onPressed: () => deleteTx(transactions[index].id),
                      )),
                );

                //everything goes here
                // return Card(
                //     child: Row( //the row for a transaction
                //   children: [
                //     Container( //for the
                //       margin: const EdgeInsets.all(10),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //         color: Theme.of(context).primaryColorDark,
                //         width: 2,
                //       )),
                //       padding: const EdgeInsets.all(10),
                // child: Text(
                //   'Rs: ${transactions[index].amount.toStringAsFixed(2)}',
                //   style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20,
                //       color: Colors.black),
                // ),
                //     ),
                //     Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                // Text(
                //   transactions[index].title.toString(),
                //   style: Theme.of(context)
                //       .textTheme
                //       .headline6, //using headline6 TextStyle from main.dart's textTheme property
                //   // TODO: but compare headline6 ko defn from here vs from main.dart. what's the get doing and what is headline6 actually?
                //   //const TextStyle(
                //   //   fontSize: 18,
                //   //   fontWeight: FontWeight.w800,
                // ),
                // Text(
                //     DateFormat.yMMMd()
                //         .format(transactions[index].date),
                //     style: const TextStyle(
                //         color: Color.fromARGB(255, 116, 114, 114),
                //         fontWeight: FontWeight.w500))
                //         ])
                //   ],
                // ));
              },
              itemCount: transactions.length,
            ),
    );
  }
}