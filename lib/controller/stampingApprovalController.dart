
import 'package:get/get.dart';
import 'package:login_app/model/teamApprovalModel.dart';
import 'package:login_app/services/teamApprovalService.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class StampingApprovalController extends GetxController {
  TeamApprovalService stampingApprovalService = TeamApprovalService();
  var stamingApproval = <TeamApprovalModel>[].obs;
  var stamingApprovalSearch = <TeamApprovalModel>[].obs;
  final detailStampingApproval = {}.obs;
  @override
  void onInit() {
    super.onInit();
    fetchDataStamping();
  }
  void fetchDataStamping() async {
    Response response = await stampingApprovalService.findAllStamping(globals.token);
    if(response.statusCode == 200) {
      stamingApproval.value = TeamApprovalModel.fromData(response.body);
      stamingApprovalSearch.value = TeamApprovalModel.fromData(response.body);
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
    stamingApproval.value = stamingApprovalSearch.value
        .where((p0) =>
    (submissionDateSearch == ''
            ? true
            : p0.submissionDate == null
            ? false
            : p0.submissionDate!.contains(submissionDateSearch)) &&
        (approvalDateSearch == ''
            ? true
            : p0.approvalDate == null
            ? false
            : p0.approvalDate!.contains(approvalDateSearch)) &&
        (p0.approval == dataSearch['approval']))
        .toList();
    stamingApproval.refresh();
  }
  void showDetailStampingApproval(String id) async {
    Response response = await stampingApprovalService.approval(globals.token, id);

    if(response.statusCode == 200){
      detailStampingApproval.value = response.body;

      Get.toNamed('/stamping-approval-detail/$id');
    }
  }
}
