import 'dart:convert';

import 'package:get/get.dart';
import 'package:login_app/auth/authentical.dart';
import 'package:login_app/model/TeamApprovalModel.dart';
import 'package:login_app/services/teamApprovalService.dart';
import 'package:login_app/global-variable/globals.dart' as globals;


class TeamApprovalController extends GetxController {
  TeamApprovalService teamApprovalService = TeamApprovalService();
  var isLoading = false.obs;
  var teamApproval = [].obs;
  var teamApprovalSearch = [].obs;
  var officeNameUnique = [].obs;
  var detailTeamApproval = new TeamApprovalModel().obs;
  var seen = Set<String>();
  final token = AuthenticationManager().getToken();
  @override
  void onInit() {
    super.onInit();

    fetchDataOfLuyn();
  }

   void fetchDataOfLuyn() async {

    try {
      isLoading(true);
      Response response = await TeamApprovalService().findAllOfLuyn(token!);
      if (response.statusCode == 200) {
        teamApproval.value = teamApprovalSearch.value =
            TeamApprovalModel.fromData(response.body);

        uniqueList();
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  void uniqueList(){
    officeNameUnique.value = teamApproval.where((country) => seen.add(country.officeName)).toList();
  }

  void dataSearch(Map<String, dynamic> dataSearch) {
    String submissionDateSearch = dataSearch['submissionDate'];
    String approvalDateSearch = dataSearch['approvalDate'];


    submissionDateSearch == ''
        ? ''
        : submissionDateSearch = submissionDateSearch.substring(0, 10);
    approvalDateSearch == ''
        ? ''
        : approvalDateSearch = approvalDateSearch.substring(0, 10);

    print('submissionDate');
    print(submissionDateSearch);
    print('approvalDate');
    print(approvalDateSearch);
    teamApproval.value = teamApprovalSearch.value
        .where((p0) =>
            (dataSearch['officeName'] == ''
                ? true
                : p0.officeName.contains(dataSearch['officeName'])) &&
            (dataSearch['driverName'] == ''
                ? true
                : p0.driverName.contains(dataSearch['driverName'])) &&
            (submissionDateSearch == ''
                ? true
                : p0.submissionDate == null
                    ? false
                    : p0.submissionDate.contains(submissionDateSearch)) &&
            (approvalDateSearch == ''
                ? true
                : p0.approvalDate == null
                    ? false
                    : p0.approvalDate.contains(approvalDateSearch)) &&
            (p0.approval == dataSearch['approval']))
        .toList();
  }

  void updateTeamApproval(String id, Map<String, dynamic> data) async {
      Response response = await teamApprovalService.updateTeamApproval(globals.token,id,data);

      if(response.statusCode == 200){

        print(response.body);
      }
  }


  void showDetailTeamApproval(String id) async {
    Response response = await teamApprovalService.approval(token!, id);
    print(response.statusCode);
    if(response.statusCode == 200){
      detailTeamApproval.value = TeamApprovalModel.fromJson(response.body);
      print(detailTeamApproval.value);
      Get.toNamed('/screenCheckTeamDetail/$id');
    }

  }
}
