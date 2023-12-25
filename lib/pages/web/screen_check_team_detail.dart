import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/controller/teamApprovalController.dart';
import 'package:login_app/model/TeamApprovalModel.dart';


class ScreenCheckTeamDetail extends StatelessWidget {
   ScreenCheckTeamDetail({super.key});
   TeamApprovalController teamApprovalController = Get.put(TeamApprovalController());
    TextEditingController reason = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('打刻承認詳細', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                    SizedBox(height: 10),
                    Text('事務所:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: teamApprovalController.detailTeamApproval.value.officeName,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('運転手名:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: teamApprovalController.detailTeamApproval.value.driverName,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('申請日時:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: teamApprovalController.detailTeamApproval.value.submissionDate,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('承認有無:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: (teamApprovalController.detailTeamApproval.value.approval == true ? 'Đã Phê Duyệt' : 'Chưa Phê Duyệt'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('修正前打刻:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: teamApprovalController.detailTeamApproval.value.stampingBeforeCorrection,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('修正後打刻:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: teamApprovalController.detailTeamApproval.value.stampingAfterCorrection,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('承認/差∪戻乚理由:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                        controller: reason,
                        decoration: InputDecoration(
                          hintText: teamApprovalController.detailTeamApproval.value.reason,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () {
                          Map<String, dynamic> data = {
                            "approval" :(teamApprovalController.detailTeamApproval.value.approval),
                            "reason": teamApprovalController.detailTeamApproval.value.reason
                          };
                          teamApprovalController.updateTeamApproval(teamApprovalController.detailTeamApproval.value.stampApprovalId.toString(),data);
                        }, child: Text('承認'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, fixedSize: Size(80, 40)),),
                        SizedBox(width: 10),
                        ElevatedButton(onPressed: () {
                          Get.toNamed("screenCheckTeam");
                        }, child: Text('差し戻し'), style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,fixedSize: Size(110, 40)),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}