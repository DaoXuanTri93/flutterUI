import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/controller/teamApprovalController.dart';
import 'package:login_app/model/TeamApprovalModel.dart';


class ScreenCheckTeamDetail extends StatelessWidget {
   ScreenCheckTeamDetail({super.key});
   TeamApprovalController teamApprovalController = Get.put(TeamApprovalController());

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    Map<String, dynamic> teamApprovalData;
    var stampApprovalId;
    var officeName;
    var driverName;
    var submissionDate;
    var approval;
    var approvalDate;
    var stampingBeforeCorrection;
    var stampingAfterCorrection;
    var reasons;
    TextEditingController reason = TextEditingController();

    stampApprovalId = data.stampApprovalId;
    officeName = data.officeName;
    driverName = data.driverName;
    submissionDate = data.submissionDate;
    approval = data.approval.toString();
    approvalDate = data.approvalDate;
    stampingBeforeCorrection = data.stampingBeforeCorrection;
    stampingAfterCorrection = data.stampingAfterCorrection;
    reasons = data.reason;

    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('打刻承認詳細', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                  SizedBox(height: 10),
                  Text('事務所:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: officeName,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('運転手名:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: driverName,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('申請日時:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: submissionDate,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('承認有無:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: approval,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('修正前打刻:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: stampingBeforeCorrection,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('修正後打刻:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: stampingAfterCorrection,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('承認/差∪戻乚理由:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 10),
                  TextField(
                      controller: reason,
                      decoration: InputDecoration(
                        hintText: reasons,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(onPressed: () {
                        teamApprovalData = {
                         'stampApprovalId': stampApprovalId,
                         'officeName': officeName,
                         'driverName': driverName,
                         'submissionDate': submissionDate,
                         'approval': approval,
                         'approvalDate': approvalDate,
                         'stampingBeforeCorrection': stampingBeforeCorrection,
                         'stampingAfterCorrection': stampingAfterCorrection,
                          'reason': reason.text
                       };
                       print(teamApprovalData.runtimeType);
                        teamApprovalController.updateTeamApproval(teamApprovalData);

                      }, child: Text('承認'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, fixedSize: Size(80, 40)),),
                      SizedBox(width: 10),
                      ElevatedButton(onPressed: () {
                        Get.back();
                      }, child: Text('差し戻し'), style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,fixedSize: Size(110, 40)),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}