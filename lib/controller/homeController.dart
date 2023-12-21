
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/officeProviders.dart';

class HomeController extends GetxController {
  String MAC ="";
  void getMacAddress() async{
    Map<String, dynamic> deviceData = await OfficeProviders().initPlatformState();
    if(deviceData.isEmpty){
      MAC = "";
    }else{
      MAC = deviceData["id"];
      print(MAC);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if(!kIsWeb) getMacAddress();
  }
}
