import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/staffModel.dart';
import 'package:login_app/const/const.dart';

class StaffUserController extends GetxController {
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
    final String staffUserUrl = '$SEVERNAME/staff';
    final response = await http.get(Uri.parse(staffUserUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      staffUserList.value = staffUserSearchList.value =
          result.map((e) => StaffUser.fromJson(e)).toList();

      isLoading.value = false;
    } else {
      Get.snackbar('Error Loading Data !!! ',
          'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}');
    }
  }

  getAllStaffUserDetail(String id) async {
    try {
      final String staffUserDetailUrl = '$SEVERNAME/staff/$id';
      final response = await http.get(Uri.parse(staffUserDetailUrl));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        staffUserListDetail.value = StaffUser.fromData(result);
        Get.toNamed('/users-details', arguments: id);

        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar('Error Loading Data !!! ', 'Sever Responded : $e');
    }
  }

  searchStaffUser(Map<String, dynamic> staffUser) {
    staffUserList.value = staffUserSearchList.value
        .where((e) =>
            (staffUser['affiliatedOffice'] == ''
                ? true
                : e.affiliatedOffice.contains(staffUser['affiliatedOffice'])) &&
            (staffUser['role'] == ''
                ? true
                : e.role.contains(staffUser['role'])) &&
            (staffUser['userName'] == ''
                ? true
                : e.userName.contains(staffUser['userName'])))
        .toList();
  }

  createStaffUser(StaffUser staffUser) async {
    try {
      final String createStaffUser = '$SEVERNAME/staff';
      final response =
          await http.post(Uri.parse(createStaffUser), body: staffUser.toJson());

      if (response.statusCode == 201) {
        getAllStaffUser();
        Get.snackbar('Thành Công', 'đã tạo mới một Staff User',
            backgroundColor: Colors.lightGreen);
      }
    } catch (e) {
      Get.snackbar('Error Loading Data !!! ', 'Sever Responded : $e');
    }
  }

  updateStaffUser(String id, StaffUser staffUser) async {
    final String updateStaffUser = '$SEVERNAME/staff/$id';
    final response =
        await http.put(Uri.parse(updateStaffUser), body: staffUser.toJson());

    if (response.statusCode == 200) {
      Get.snackbar('Thành Công', 'cập nhập Staff User thành công',
          backgroundColor: Colors.lightGreen);
      getAllStaffUserDetail(id);
      getAllStaffUser();
    } else {
      (Get.snackbar('Error Loading Data !!! ',
          'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}'));
    }
  }
}
