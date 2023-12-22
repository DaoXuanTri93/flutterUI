import 'package:get/get.dart';
import 'package:login_app/model/TeamApprovalModel.dart';
import 'package:login_app/services/teamApprovalService.dart';

class TeamApprovalController extends GetxController {
  TeamApprovalService teamApprovalService = TeamApprovalService();
  var isLoading = false.obs;
  var teamApproval = [].obs;
  var teamApprovalSearch = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    // Future.delayed(const Duration(seconds: 2), () async {   });
  }

  void fetchData() async {
    try {
      isLoading(true);
      Response response = await TeamApprovalService().findAll();
      if (response.statusCode == 200) {
        teamApproval.value = teamApprovalSearch.value =
            TeamApprovalModel.fromData(response.body);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
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

  void updateTeamApproval(Map<String, dynamic> data) async {
    String id = data['stampApprovalId'];
      print('update');
      print(data);
      Response response = await teamApprovalService.updateTeamApproval(id);
      if(response.statusCode == 200){
        print(response.body);
      }

  }
}
