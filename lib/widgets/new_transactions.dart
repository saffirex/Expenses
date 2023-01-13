import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController(); //object of this type
  final amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = titleController.text;

    if (amountController.text.isEmpty) {
      return;
    }

    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    // print('pressed...');
    // print(titleController.text);
    // print(amountController.text);
    widget.addTx(titleController.text, double.parse(amountController.text), _selectedDate); //calling addTx function whose definition is in the main.dart file as _addNewTransaction
    Navigator.of(context).pop(); //pops the modalsheet
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      //.then defines what happens when future is complete
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      //using setstate for the value which should cause the build function to rerun

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only( top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom +30),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                // onChanged: (instantaneousEnteredValue) =>
                //     inputTitle = instantaneousEnteredValue,
              ),
              TextField(
                // onChanged: (instantaneousEnteredValue) =>
                //     inputAmount = instantaneousEnteredValue,
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(), //seethis[1]
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Please Pick a Date'
                          : 'Date Picked: ${DateFormat.yMd().format(_selectedDate!)}'),
                    ),
                    ElevatedButton(
                      child: Text('Choose Date'),
                      onPressed: _datePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _submitData, //seethis[2]
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                      child: const Text('Submit'))),
            ],
          ),
        ),
      ),
    );
  }
}
