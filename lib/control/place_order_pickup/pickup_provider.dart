import 'dart:developer';
import 'package:flutter/material.dart';

class PickupProvider extends ChangeNotifier {
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDay = DateTime.now();

  TimeOfDay get selectedTime => _selectedTime;
  DateTime get selectedDay => _selectedDay;

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime, // Optional: Set the initial time
    );
    if (picked != null && picked != _selectedTime) {
      _selectedTime = picked;
      notifyListeners();
    }
  }

  void selectDate(selectedDay, focusedDay) {
    log('selected Date: $selectedDay');
    // int selectedDay = int.parse(selectedDay);
    _selectedDay = selectedDay;
    notifyListeners();
  }
}
