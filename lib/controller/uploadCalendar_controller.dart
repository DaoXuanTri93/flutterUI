import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class uploadCalendarController extends GetxController {
  TextEditingController date = TextEditingController();

  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      date.text = DateFormat('MM/dd/yyyy').format(pickedDate);
    }
  }
}
