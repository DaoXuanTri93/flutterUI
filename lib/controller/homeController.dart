
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/officeProviders.dart';
import '../services/positionservices.dart';
import '../services/timekeepingservices.dart';

class HomeController extends GetxController {
  String MAC ="";
  final isCheckin = false.obs;
  final isCheckout = false.obs;
  void getMacAddress() async{
    Map<String, dynamic> deviceData = await HomeProviders().initPlatformState();
    if(deviceData.isEmpty){
      MAC = "";
    }else{
      MAC = deviceData["id"];
    }
  }

  void getDataTimeKeep() async {
    Map<String, dynamic> timeKeepData = await TimeKeepingServices().getDataTimeKeeping();
    if(timeKeepData.isNotEmpty){
      final timeStartDay = timeKeepData["timeStartDay"];
      final timeEndDay = timeKeepData["timeEndDay"];
      timeStartDay != null ? isCheckin.value = true:isCheckin.value= false;
      timeEndDay != null ? isCheckout.value = true:isCheckout.value= false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    if(!kIsWeb) getMacAddress();
    getDataTimeKeep();
  }
}
