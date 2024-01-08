import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../services/uploadImage.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class ImageController extends GetxController {

  ImageConnect imageConnect = ImageConnect();
  final token = globals.token;
  var message = ''.obs;

  void createEnterDistance(String startingPoint, String firstKilometerPhoto) async {

    Map<String, dynamic> data = {
      "startingPoint": startingPoint,
      "firstKilometerPhoto": firstKilometerPhoto,
    };
   Response response =  await imageConnect.createEnterDistance(data, token);
   if(response.statusCode == 201){
     Get.snackbar('Notification', 'Updated successfully',duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
     return EasyLoading.dismiss();
   }
    Get.snackbar('Notification', 'Updated failed' ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
    return EasyLoading.dismiss();
  }

  Future updateEnterDistance(String endPoint, String lastKilometerPhoto) async {
    Map<String, dynamic> data = {
      "endPoint": endPoint,
      "lastKilometerPhoto": lastKilometerPhoto
    };
    Response findOneDriver = await imageConnect.updateEnterDistance(data, token);
    if(findOneDriver.statusCode != 201){
      Get.snackbar(findOneDriver.body['message'], '',duration: Duration(seconds: 1) , backgroundColor: Colors.redAccent.withOpacity(0.3));
      return EasyLoading.dismiss();
    }
    Get.snackbar('Notification', 'Updated successfully',duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
    EasyLoading.dismiss();
  }
}
