import 'dart:convert';

import 'package:get/get.dart';
import 'package:login_app/model/officeModel.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/global-variable/globals.dart' as globals;
import '../const/const.dart';

class OfficeUserController extends GetxController {

  var officeUserList = <OfficeUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllOfficeUser();
  }

  getAllOfficeUser() async {

    final String staffUserUrl = '$SEVERNAME/office';
    final response = await http.get(Uri.parse(staffUserUrl),headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${globals.token}'
    });

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