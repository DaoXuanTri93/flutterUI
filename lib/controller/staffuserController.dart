import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/staffmodel.dart';

class StaffUserController extends GetxController{

  var staffUserList = <StaffUser>[].obs;
  final staffUserListDetail = <StaffUser>[].obs;
  final staffUserSearchList = <StaffUser>[].obs;

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

      staffUserList.value = staffUserSearchList.value = result.map((e) => StaffUser.fromJson(e)).toList();

      isLoading.value = false;

    }else{
      Get.snackbar('Error Loading Data !!! ',
          'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}'
      );
    }
  }

  getAllStaffUserDetail(String id) async {
   try{
     String staffUserDetailUrl = 'http://localhost:3000/staff/$id';
     final response = await http.get(Uri.parse(staffUserDetailUrl));
     if(response.statusCode==200){
       final result = jsonDecode(response.body);
       staffUserListDetail.value = StaffUser.fromData(result);
       Get.toNamed('/users-details');
     }
   } catch(e) {
     print("loi");
   }
  }

   searchStaffUser(Map<String ,dynamic> staffUser ) {
    staffUserList.value = staffUserSearchList.value
        .where((e) =>
    (staffUser['affiliatedOffice'] == '' ? true : e.affiliatedOffice.contains(staffUser['affiliatedOffice'])) &&
        (staffUser['role'] == '' ? true : e.role.contains(staffUser['role']))
        &&
        (staffUser['userName'] == '' ? true : e.userName.contains(staffUser['userName']))
            ).toList();
  }

  createStaffUser(StaffUser staffUser) async {

    const String createStaffUser = 'http://localhost:3000/staff';
    final response = await http.post(Uri.parse(createStaffUser), body:staffUser );

    if(response.statusCode == 200){
      Get.snackbar('Thành Công', 'đã tạo mới một Staff User',backgroundColor: Colors.lightGreen);
    }else {
      (
        Get.snackbar('Error Loading Data !!! ',
            'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}'
        )
    );
    }
  }

}