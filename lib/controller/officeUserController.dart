import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:login_app/model/officemodel.dart';
import 'package:http/http.dart' as http;

class OfficeUserController extends GetxController {

  var officeUserList = <OfficeUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllOfficeUser();
  }

  getAllOfficeUser() async {

    const String staffUserUrl = 'http://localhost:3000/office';
    final response = await http.get(Uri.parse(staffUserUrl));

    if(response.statusCode==200){

      final List result = jsonDecode(response.body);

      officeUserList.value = result.map((e) => OfficeUser.fromJson(e)).toList();

    }else{
      Get.snackbar('Error Loading Data !!! ',
          'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}'
      );
    }
  }
}