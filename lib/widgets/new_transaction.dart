import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.addNewTransaction})
      : super(key: key);

  final Function addNewTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountcontroller = TextEditingController();
  final _titlecontroller = TextEditingController();
  DateTime _dateSelected = DateTime.now();

  void _submitData() {
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _dateSelected == null) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount, _dateSelected);
    Navigator.of(context).pop();
  }

  void _persentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateSelected = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                // onChanged: (value) => titleInput = value,
                controller: _titlecontroller,
                onSubmitted: (_) => _submitData()),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              // onChanged: (value) => amountInput = value,
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_dateSelected == null
                        ? 'no date chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_dateSelected)}'),
                  ),
                  TextButton(
                    onPressed: _persentDatePicker,
                    child: const Text(
                      'Date Chosen',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
