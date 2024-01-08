
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:login_app/services/changePasswordService.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class ChangePasswordController extends GetxController {
  ChangePasswordService changePasswordService = ChangePasswordService();
  var datauser = [].obs;
  var message = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  fetchDatauser(Map<String, dynamic> data) async {
    Response response =
        await changePasswordService.changePassword(data, globals.token);
    if (response.statusCode != 201) {
      Get.snackbar('Incorrect password', response.body['message'],
          duration: Duration(
            milliseconds: 1500,
          ),
          backgroundColor: Colors.redAccent.withOpacity(0.3));
      return EasyLoading.dismiss();
    }
    Get.snackbar('Notification', 'Updated password successfully',
        duration: Duration(
          milliseconds: 1500,
        ),
        backgroundColor: Colors.green.withOpacity(0.3));
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.toNamed("/navigationBarDemo");
    });
    return EasyLoading.dismiss();
  }
}
