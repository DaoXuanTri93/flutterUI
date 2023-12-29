import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_app/services/scheduleservices.dart';

import '../button/button.dart';
import '../const/const.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _timeNew = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(schedulePage,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),

                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleDateSchedule,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    TextFormField(
                      controller: _date,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                          focusColor: Colors.red,
                          hintText: 'yyyy/MM/dd',
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0))),
                      onTap: () async {
                        DateTime? datepicker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025));
                        if (datepicker != null) {
                          setState(() {
                            _date.text =
                                DateFormat('yyyy/MM/dd').format(datepicker);
                          });
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleTimeStart,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    TextFormField(
                      controller: _time,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                          hintText: '--:-- --',
                          suffixIcon: const Icon(Icons.access_time),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0))),
                      onTap: () async {
                        TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.dial);
                        if (timeOfDay != null) {
                          _time.text = timeOfDay.format(context);
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleTimeEnd,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    TextFormField(
                      controller: _timeNew,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                          hintText: '--:-- --',
                          suffixIcon: const Icon(Icons.access_time),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0))),
                      onTap: () async {
                        TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.dial);
                        if (timeOfDay != null) {
                          _timeNew.text = timeOfDay.format(context);
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 10),
                ButtonScreen(
                  onPressed: () {
                    Map<String, dynamic> data = {};
                    data["date"] = _date.text;
                    data["time"] = _time.text;
                    data["timeNew"] = _timeNew.text;
                    ScheduleServices().registerSchedule(data);
                  },
                  text: const Text('申請',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  radius: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
