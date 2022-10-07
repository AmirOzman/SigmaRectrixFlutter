import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class DatePickerButton extends StatefulWidget {
  const DatePickerButton({Key? key}) : super(key: key);

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonText(
      nama: 'Select Date',
      lebar: 0.4,
      onPressed: () => pickDate(context),
    );
  }
}

Future pickDate(BuildContext context) async {
  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5));
}
