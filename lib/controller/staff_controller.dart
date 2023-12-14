import 'dart:convert';

import 'package:get/get.dart';
import 'package:login_app/models/staff_models.dart';
import 'package:http/http.dart' as http;

class StaffController extends GetxController{
  var staffList = <StaffModel>[].obs;
  var isLoading = true;

  getStaff() async {
    const String staffUrl = "http://localhost:3000/staff";
    final response = await http.get(Uri.parse(staffUrl));
    if(response.statusCode == 200) {
      jsonDecode(response.body)['data'];
    } else {
      
    }
  }
}