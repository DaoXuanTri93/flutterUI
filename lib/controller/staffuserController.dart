import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/staffmodel.dart';

class StaffUserController extends GetxController{

  var staffUserList = <StaffUser>[].obs;
  var isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    getAllStaffUser();
  }

  getAllStaffUser() async {

    const String staffUserUrl = 'http://localhost:3000/staff';
    final response = await http.get(Uri.parse(staffUserUrl));

    if(response.statusCode==200){

      final List result = jsonDecode(response.body);

      staffUserList.value = result.map((e) => StaffUser.fromJson(e)).toList();

      isLoading.value = false;

      update();
    }else{
      Get.snackbar('Error Loading Data !!! ',
          'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}'
      );
    }
  }
}