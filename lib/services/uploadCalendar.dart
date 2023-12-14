import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/uploadCalendar_controller.dart';


class UpLoadCalendar extends StatelessWidget {
  UpLoadCalendar({super.key});

   final uploadCalendarController controller = Get.put(uploadCalendarController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: controller.date,
        keyboardType: TextInputType.none,
        decoration: const InputDecoration(
          hintText: 'mm/dd/yyyy',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: Icon(Icons.calendar_today_rounded),
        ),
        onTap: () {
          controller.pickDate();
        },
      ),
    );
  }
}

