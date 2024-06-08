import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> appDateTimePicker(BuildContext context, TextEditingController controller) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (selectedDate != null) {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      controller.text = DateFormat('h:mm a, dd MMMM yyyy').format(selectedDateTime);
    }
  }
}
