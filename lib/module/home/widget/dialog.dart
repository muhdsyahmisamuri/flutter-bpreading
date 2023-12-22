import 'package:bp_reading/module/home/controller/home_controller.dart';
import 'package:bp_reading/module/home/controller/item_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool confirm = false;

class TwoTextFieldDialog extends StatefulWidget {
  final String title;

  const TwoTextFieldDialog({super.key, required this.title});
  @override
  _TwoTextFieldDialogState createState() => _TwoTextFieldDialogState();
}

class _TwoTextFieldDialogState extends State<TwoTextFieldDialog> {
  TextEditingController textFieldSysController = TextEditingController();
  TextEditingController textFieldDiaController = TextEditingController();
  TextEditingController textFieldPulseController = TextEditingController();
  TextEditingController textFieldDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: textFieldSysController,
                decoration: InputDecoration(
                  hintText: 'Systolic',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: textFieldDiaController,
                decoration: InputDecoration(
                  hintText: 'Diastolic',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: textFieldPulseController,
                decoration: InputDecoration(
                  hintText: 'Pulse',
                ),
              ),
              GestureDetector(
                onTap: _showDateTimePicker,
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextFormField(
                    maxLength: 20,
                    enabled: true,
                    controller: textFieldDateTimeController,
                    decoration: InputDecoration(
                      labelText: 'Date & Time',
                      hintText: 'dd/MM/yyyy HH:mm',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      suffixIcon: Icon(Icons.date_range),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            if (_areAllFieldsFilled()) {
              confirm = true;
              print('Systolic: ${textFieldSysController.text}');
              print('Diastolic: ${textFieldDiaController.text}');
              print('Pulse: ${textFieldPulseController.text}');
              print('Date & Time: ${textFieldDateTimeController.text}');

              ItemData newItem = ItemData(
                systolic: textFieldSysController.text,
                diastolic: textFieldDiaController.text,
                pulse: textFieldPulseController.text,
                dateTime: textFieldDateTimeController.text,
              );

              HomeController.instance.addItem(newItem);

              Navigator.pop(context);
            } else {
              _showSnackBar(
                context,
                'Please fill in all fields',
              );
            }
          },
          child: const Text("OK"),
        ),
      ],
    );
  }

  void _showDateTimePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDateTime =
            DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

        setState(() {
          textFieldDateTimeController.text = formattedDateTime;
        });
      }
    }
  }

  bool _areAllFieldsFilled() {
    return textFieldSysController.text.isNotEmpty &&
        textFieldDiaController.text.isNotEmpty &&
        textFieldPulseController.text.isNotEmpty &&
        textFieldDateTimeController.text.isNotEmpty;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }
}
