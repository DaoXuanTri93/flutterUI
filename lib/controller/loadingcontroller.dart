import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../auth/authentical.dart';
import '../services/missionServices.dart';

class LoadingController extends GetxController {
  final user = {}.obs;

  void initUser() {
    Future.delayed(const Duration(seconds: 2), () async {
      getInstance().whenComplete(() =>
      // Get.toNamed("/loginpage"));
      user.value.isNotEmpty ? kIsWeb ? Get.offNamed("/driver-infor"): Get.toNamed("/homepage") : Get.toNamed("/loginpage"));
    });
  }

  Future getInstance() async {
    user.value = await AuthenticationManager().checkLoginStatus();
  }
  @override
  void onInit() {
    super.onInit();
    initUser();
  }
}