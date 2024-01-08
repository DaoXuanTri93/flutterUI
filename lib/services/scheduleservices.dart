import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/global-variable/globals.dart' as globals;
import 'package:login_app/services/homeProviders.dart';


class ScheduleServices {
  registerSchedule(Map data) async{
    final token = globals.token;
    Response response = await HomeProviders().registerSchedule(token, data);
    if (response.statusCode != 201) {
      Get.snackbar('Notification', 'Register failed' ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
      return false;
    }
    Get.snackbar('Notification', 'Register successfully',duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
    return false;
  }
}