import 'package:get/get.dart';
import 'package:login_app/const/const.dart';

import '../model/log_models.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class LogController extends GetxController {
  var logList = [].obs;
  var searchLogList = [].obs;
  var officeUserList = [].obs;
  var role = [].obs;
  var status = [].obs;
  var seenstatus = Set<String>();
  var seen = Set<String>();
  var seenrole = Set<String>();
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    getLog();
  }

  final _connect = GetConnect();
  getLog() async {
    final String logUrl = '$SEVERNAME/logapproval';
    final response = await _connect.get(logUrl,headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${globals.token}'
    });

    if (response.statusCode == 200) {
      print(response.body);
      logList.value =
          searchLogList.value = response.body.map((e) => Log.fromJson(e)).toList();
      uniqueList();
      print(logList[0].affiliatedOffice);
    } else {
      Get.snackbar('Error Loading Data !!! ',
          'Sever Responded : ${response.statusCode} : ${response.status}');
    }
  }

  void uniqueList(){
    officeUserList.value = logList.where((country) => seen.add(country.affiliatedOffice)).toList();
    role.value = logList.where((country) => seenrole.add(country.type)).toList();
    status.value = logList.where((country) => seenstatus.add(country.kinds)).toList();
  }

  void searchListLog(Map<String, dynamic> log) async {
    searchLogList.value = logList.value
        .where((e) =>
            (log['officeName'] == '' ||
                e.affiliatedOffice!.contains(log['officeName'])) &&
            (log['role'] == '' || e.type!.contains(log['role'])) &&
            (log['operatorName'] == '' ||
                e.operatorName!.contains(log['operatorName'])) &&
            (log['approvalDay'] == '' || e.date!.contains(log['approvalDay'])) &&
            (log['status'] == '' || e.kinds!.contains(log['status'])) &&
            (log['hourApproval'] == '' ||
                e.operationTime!.contains(log['hourApproval'])))
        .toList();
  }
}
