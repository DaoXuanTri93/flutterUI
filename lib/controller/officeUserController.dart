import 'dart:convert';

import 'package:get/get.dart';
import 'package:login_app/model/officeModel.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/global-variable/globals.dart' as globals;
import '../const/const.dart';

class OfficeUserController extends GetxController {

  var officeUserList = <OfficeUser>[].obs;
  var officeUserListOne = <OfficeUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllOfficeUser();
    findOfficeStaff();
  }

  getAllOfficeUser() async {

    final String staffUserUrl = '$SEVERNAME/office';
    final response = await http.get(Uri.parse(staffUserUrl),headers: {
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

  findOfficeStaff() async {
    final String findOfficeStaffUrl = '$SEVERNAME/office/info';
    final response = await http.get(Uri.parse(findOfficeStaffUrl),headers: {
      'Authorization': 'Bearer ${globals.token}'
    });

    if(response.statusCode == 200){
      final List result = jsonDecode(response.body);
      officeUserListOne.value = result.map((e) => OfficeUser.fromJson(e)).toList();
    }

  }
}