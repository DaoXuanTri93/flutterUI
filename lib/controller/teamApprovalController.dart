
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
        print(teamApproval.runtimeType);
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

    teamApproval.value = teamApprovalSearch
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
            : p0.submissionDate.contains(submissionDateSearch))


        &&
        (approvalDateSearch == ''
            ? true
            : p0.approvalDate == null
            ? false
            : p0.approvalDate.contains(approvalDateSearch)) &&
        (p0.approval == dataSearch['approval']))
        .toList();
    teamApprovalSearch.refresh();

  }


  void updateTeamApproval(Map<String, dynamic> data) async {
    String id = data['stampApprovalId'];
    print("id");
    print(id);
    print('data');
    print(data);
    Response response = await teamApprovalService.updateTeamApproval(id,data,globals.token);
    if(response.statusCode == 201){
      teamApprovalSearch.value[data['index']].approval = teamApproval.value[data['index']].approval = true;
      teamApprovalSearch.value[data['index']].status = teamApproval.value[data['index']].status = data["status"];
      teamApprovalSearch.value[data['index']].approvalDate = teamApproval.value[data['index']].approvalDate = response.body['approvalDate'];
      teamApprovalSearch.value[data['index']].reason = teamApproval.value[data['index']].reason = data["reason"];

      teamApproval.refresh();
      teamApprovalSearch.refresh();
    }
  }

  void updateTeamApproval1(Map<String, dynamic> data) async {
    String id = data['stampApprovalId'];
    Response response = await teamApprovalService.updateTeamApproval(id,data,globals.token);

    if(response.statusCode == 201){
      for(var i = 0; i < teamApprovalSearch.length; i++){
        if(teamApprovalSearch[i].stampApprovalId == id){
          teamApprovalSearch[i].approval = data["approval"];
          teamApprovalSearch[i].status = data["status"];
          teamApprovalSearch[i].approvalDate = response.body['approvalDate'];
          teamApprovalSearch[i].reason = data["reason"];
        }
      }
      if(response.body["stampApprovalId"] == id){
        teamApproval.map((e){
          if(e.stampApprovalId == id){
            e.approval = true;
            e.status = data["status"];
            e.approvalDate = response.body['approvalDate'];
            e.reason = data["reason"];
            return e;
          }
          return null;
        });

      }
      teamApproval.refresh();
      teamApprovalSearch.refresh();
    }
  }

  void showDetailTeamApproval(String id) async {
    Response response = await teamApprovalService.approval(globals.token, id);
    if(response.statusCode == 200){
      detailTeamApproval.value = TeamApprovalModel.fromJson(response.body);
      Get.toNamed('/screenCheckTeamDetail/$id');
    }

  }
}