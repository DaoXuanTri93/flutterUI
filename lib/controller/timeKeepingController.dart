import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../services/timekeepingservices.dart';

class TimekeepingController extends GetxController {
  final isCheckin = false.obs;
  final isCheckout = false.obs;
  final listMission = [].obs;

  void getDataTimeKeep() async {
    Map<String, dynamic> timeKeepData =
        await TimeKeepingServices().getDataTimeKeeping();
    if (timeKeepData.isNotEmpty) {
      final timeStartDay = timeKeepData["timeStartDay"];
      final timeEndDay = timeKeepData["timeEndDay"];
      timeStartDay != null ? isCheckin.value = true : isCheckin.value = false;
      timeEndDay != null ? isCheckout.value = true : isCheckout.value = false;
    }
  }

  void checkIn() async {
    isCheckin.value = await TimeKeepingServices().checkin();
  }

  void checkOut() async {
    isCheckout.value = await TimeKeepingServices().checkout();
  }

  @override
  void onInit() {
    super.onInit();
    getDataTimeKeep();
  }
}
