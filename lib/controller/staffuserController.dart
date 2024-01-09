import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/staffModel.dart';
import 'package:login_app/const/const.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class StaffUserController extends GetxController {
  var staffUserList = <StaffUser>[].obs;
  final staffUserListDetail = {}.obs;
  final staffUserSearchList = <StaffUser>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllStaffUser();
  }

  getAllStaffUser() async {
   try {
     final String staffUserUrl = '$SEVERNAME/staff';
     final response = await http.get(Uri.parse(staffUserUrl),
         headers: {'Authorization': 'Bearer ${globals.token}'});

     if (response.statusCode == 200) {
       final List result = jsonDecode(response.body);

       staffUserList.value = staffUserSearchList.value =
           result.map((e) => StaffUser.fromJson(e)).toList();

       isLoading.value = false;
     } else {
       Get.snackbar('Error Loading Data !!! ',
           'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}',
           backgroundColor: Colors.redAccent);
     }
   }catch (e) {
     throw Exception(e);
   }
  }

  getAllStaffUserDetail(String id) async {
    try {
      final String staffUserDetailUrl = '$SEVERNAME/staff/$id';
      final response = await http.get(Uri.parse(staffUserDetailUrl),
          headers: {'Authorization': 'Bearer ${globals.token}'});

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        staffUserListDetail.value = result;

        Get.toNamed('/users-details', arguments: id);

        isLoading.value = false;
      }else {
        Get.snackbar('Error Loading Data !!! ',
            'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}',
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  searchStaffUser(Map<String, dynamic> staffUser) {
    staffUserList.value = staffUserSearchList.value
        .where((e) =>
            (staffUser['affiliatedOffice'] == ''
                ? true
                : e.affiliatedOffice.toLowerCase().contains(staffUser['affiliatedOffice'].toLowerCase())) &&
            (staffUser['role'] == ''
                ? true
                : e.role.toLowerCase().contains(staffUser['role'].toLowerCase())) &&
            (staffUser['userName'] == ''
                ? true
                : e.userName.toLowerCase().contains(staffUser['userName'].toLowerCase())))
        .toList();
  }

  createStaffUser(StaffUser staffUser) async {
    try {
      final String createStaffUser = '$SEVERNAME/staff';
      final response = await http.post(Uri.parse(createStaffUser),
          body: staffUser.toJson(),
          headers: {'Authorization': 'Bearer ${globals.token}'});

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Staff User New Has Been Created',
            backgroundColor: Colors.lightGreen);
        getAllStaffUser();
      } else {
        Get.snackbar('Error Loading Data !!! ',
            'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}',
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  updateStaffUser(String id, StaffUser staffUser) async {
    try {
      final String updateStaffUser = '$SEVERNAME/staff/$id';
      final response = await http.put(Uri.parse(updateStaffUser),
          body: staffUser.toJson(),
          headers: {'Authorization': 'Bearer ${globals.token}'});
      if (response.statusCode == 200) {
        getAllStaffUser();
        return Get.snackbar('Notification', 'Updated successfully',duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
      }
      return (Get.snackbar('Error Loading Data !!! ', 'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}',
          backgroundColor: Colors.redAccent.withOpacity(0.3), duration: Duration(milliseconds: 1500)));
    }
    catch (e) {
      throw Exception(e);
    }
  }
}
