import 'package:get/get.dart';
import '../services/missionServices.dart';

class MissionController extends GetxController {
  final listMission = [].obs;

  Future getDataMission() async {
    final missionData = await MissionServices().getDataMission();
    listMission.assignAll(missionData);
    listMission.refresh();
    return listMission;
  }

  @override
  void onInit() {
    super.onInit();
    getDataMission();
  }
}
