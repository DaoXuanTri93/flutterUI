import 'package:get/get.dart';
import 'package:login_app/model/missionApproval.dart';
import 'package:login_app/services/screenCheckMissionService.dart';

class CheckMissionController extends GetxController {
  var dataMission = [].obs;
  var dataMissionSearch = [].obs;
  var missionStatusUnique = [].obs;
  var seen = Set<String>();
  var detailMissionApproval = MissionApprovalModel().obs;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      Response response = await CheckMissionService().fetchData();
      if (response.statusCode == 200) {
        dataMission.value = dataMissionSearch.value =
            MissionApprovalModel.fromData(response.body);
        uniqueList();
      }
    } catch (e) {
      print('Error while getting data is $e');
    }
  }

  void uniqueList() {
    missionStatusUnique.value =
        dataMission.where((e) => seen.add(e.statusMission)).toList();
  }

  void approvalMission(String id) async {
    try {
      Map<String, dynamic> data = {"status" :"APPROVED"};
      Response response = await CheckMissionService().statusMissionService(id,data);
      if(response.statusCode == 201){
        for(var i = 0; i < dataMissionSearch.length; i++){
          if(dataMissionSearch[i].id == id){
            dataMissionSearch[i].statusMission = data["status"];
          }
        }
        for(var i = 0; i < dataMission.length; i++){
          if(dataMission[i].id == id){
            dataMission[i].statusMission = data["status"];
          }
        }
        dataMission.refresh();
        dataMissionSearch.refresh();
      }
    } catch (e) {
      print('Error while getting data is $e');
    }
  }

  void refuseMission(String id) async {
    try {
      Map<String, dynamic> data = {"status" :"REFUSE"};
      Response response = await CheckMissionService().statusMissionService(id,data);
      if(response.statusCode == 201){
        for(var i = 0; i < dataMissionSearch.length; i++){
          if(dataMissionSearch[i].id == id){
            dataMissionSearch[i].statusMission = data["status"];
          }
        }
        for(var i = 0; i < dataMission.length; i++){
          if(dataMission[i].id == id){
            dataMission[i].statusMission = data["status"];
          }
        }
        dataMission.refresh();
        dataMissionSearch.refresh();
      }
    } catch (e) {
      print('Error while getting data is $e');
    }
  }

  void dataSearch(Map dataSearch){
    String startDayNew = dataSearch['startDay'];
    String endDayNew = dataSearch['endDay'];

    startDayNew == '' ? '' : startDayNew = startDayNew.substring(0, 10);
    endDayNew == '' ? '' : endDayNew = endDayNew.substring(0, 10);

    dataMission.value = dataMissionSearch.where((p0) =>
    (dataSearch['userName'] == '' ? true : p0.userName.contains(dataSearch['userName'])) &&
        (startDayNew == '' ? true : p0.startDay == null ? false : p0.startDay.contains(startDayNew)) &&
        (endDayNew == '' ? true : p0.endDay == null ? false : p0.endDay.contains(endDayNew)) &&
        (p0.statusMission.contains(dataSearch['statusMission'])))
        .toList();
  }

}
