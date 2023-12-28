
import 'package:get/get.dart';
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
  var isCheck = false.obs;
  // final token = AuthenticationManager().getToken();
  @override
  void onInit() {
    super.onInit();

    fetchDataOfLuyn();
  }

   void fetchDataOfLuyn() async {

    try {
      isLoading(true);
      Response response = await TeamApprovalService().findAllOfLuyn(globals.token);
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


  void updateTeamApproval(Map<String, dynamic> data, teamApprovalController1) async {
    String id = data['stampApprovalId'];

      Response response = await teamApprovalService.updateTeamApproval(id,data,globals.token);
      if(response.statusCode == 200){

      }
    // teamApprovalController1.dataSearch();
    // teamApprovalController1.refresh();
  }

  void approvalButton(Map<String, dynamic> data, teamApprovalController1) async {
    String id = data['stampApprovalId'];
    // teamApprovalSearch.value = [];
    Response response = await teamApprovalService.updateTeamApproval(id,data,globals.token);
    print(response.statusCode);
    if(response.statusCode == 201){

    }
    // teamApprovalController1.fetchDataOfLuyn();
    // teamApprovalController1.refresh();
    // teamApprovalSearch.refresh();

  }


  void showDetailTeamApproval(String id) async {
    Response response = await teamApprovalService.approval(globals.token, id);
    print(response.statusCode);
    if(response.statusCode == 200){
      detailTeamApproval.value = TeamApprovalModel.fromJson(response.body);
      print(detailTeamApproval.value);
      Get.toNamed('/screenCheckTeamDetail/$id');
    }

  }
}
