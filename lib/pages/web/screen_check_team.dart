import 'dart:async';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:login_app/controller/teamApprovalController.dart';

class ScreenCheckTeam extends StatelessWidget {
  ScreenCheckTeam({super.key});

  final TeamApprovalController teamApprovalController =
      Get.put<TeamApprovalController>(TeamApprovalController());
  var stampApprovalId = ''.obs;
  var staff = ''.obs;
  var approval = false.obs;
  var officeName = ''.obs;
  TextEditingController driverName = TextEditingController();
  TextEditingController submissionDate = TextEditingController();
  TextEditingController approvalDate = TextEditingController();
  var stampingBeforeCorrection = ''.obs;
  var stampingAfterCorrection = ''.obs;
  var reason = ''.obs;
  late Map<String, dynamic> dataSearch;

  // final Color color = ;
  List<String> team = [
    '事務所',
    '運転手名',
    '申請日時',
    '承認日時',
    '承認有無',
    '修正前打刻',
    '修正後打刻',
    '承認'
  ];

  @override
  Widget build(BuildContext context) {
    SingleValueDropDownController controller = SingleValueDropDownController();
    // teamApprovalController.fetchDataOfLuyn();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('打刻承認検索',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              const Text('事務所:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Obx(
                () => DropDownTextField(
                  textFieldDecoration:
                      InputDecoration(border: OutlineInputBorder()),
                  dropDownList: List.generate(
                      teamApprovalController.officeNameUnique.value.length,
                      (index) {
                    return DropDownValueModel(
                        name: teamApprovalController
                            .officeNameUnique.value[index].officeName,
                        value: teamApprovalController
                            .officeNameUnique.value[index].stampApprovalId);
                  }),
                  controller: controller,
                  onChanged: (value) {
                    controller.dropDownValue == null
                        ? officeName.value = ''
                        : officeName.value = controller.dropDownValue!.name;
                  },
                ),
              ),
              const Text('運転手名:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextField(
                controller: driverName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const Text('申請日:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextField(
                controller: submissionDate,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'mm/dd/yyyy --:-- --',
                    suffixIcon: Icon(Icons.calendar_today)),
                onTap: () async {
                  DateTime? datepicker = await showDatePicker(
                      // confirmText: 'bam vo day',
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));

                  if (datepicker != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    submissionDate.text =
                        DateFormat('yyyy/MM/dd ').format(datepicker) +
                            pickedTime!.format(context);
                  }
                },
              ),
              const Text('承認日:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextField(
                controller: approvalDate,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'mm/dd/yyyy --:-- --',
                    suffixIcon: Icon(Icons.calendar_today)),
                onTap: () async {
                  DateTime? datepicker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (datepicker != null) {
                    TimeOfDay? pickedTimed = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    approvalDate.text =
                        DateFormat('yyyy/MM/dd ').format(datepicker) +
                            pickedTimed!.format(context);
                    ;
                  }
                },
              ),
              const Text('出張有無:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Checkbox(
                      value: approval.value,
                      onChanged: (value) {
                        approval.value = value!;
                      },
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    dataSearch = {
                      "stampApprovalId": stampApprovalId.value,
                      "staff": staff.value,
                      "approval": approval.value,
                      "officeName": officeName.value,
                      "driverName": driverName.text,
                      "submissionDate": submissionDate.text,
                      "approvalDate": approvalDate.text,
                      "stampingBeforeCorrection":
                          stampingBeforeCorrection.value,
                      "stampingAfterCorrection": stampingAfterCorrection.value,
                      "reason": reason.value,
                    };

                    teamApprovalController.dataSearch(dataSearch);
                  },
                  child: const Text('検索')),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: DataTable(
                      sortColumnIndex: 1,
                      sortAscending: true,
                      columns: team
                          .map((e) => DataColumn(
                                  label: Expanded(
                                      child: Center(
                                          child: Text(
                                e,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )))))
                          .toList(),
                      rows: List.generate(
                          teamApprovalController.teamApproval.value.length,
                          (index) {
                        return DataRow(
                            onLongPress: () {
                              teamApprovalController.showDetailTeamApproval(
                                  teamApprovalController
                                      .teamApproval.value[index].stampApprovalId
                                      .toString());
                            },
                            // selected: true,
                            cells: [
                              DataCell(Center(
                                  child: Text(teamApprovalController
                                      .teamApproval.value[index].officeName
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(teamApprovalController
                                      .teamApproval.value[index].driverName
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(teamApprovalController
                                      .teamApproval.value[index].submissionDate
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(teamApprovalController
                                      .teamApproval.value[index].approvalDate
                                      .toString()))),
                              DataCell(((teamApprovalController
                                          .teamApproval.value[index].approval ==
                                      false
                                  ? Center(
                                      child: Text('Chờ Phê Duyệt',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold)))
                                  : Center(
                                      child: Text('Đã Phê Duyệt',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold)))))),
                              DataCell(Center(
                                  child: Text(teamApprovalController
                                      .teamApproval
                                      .value[index]
                                      .stampingBeforeCorrection
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(teamApprovalController
                                      .teamApproval
                                      .value[index]
                                      .stampingAfterCorrection
                                      .toString()))),
                              DataCell(Center(
                                child: ElevatedButton(
                                  onHover: (value) {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                  ),
                                  child: Text(
                                    '変更',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Map<String, dynamic> data = {
                                      "index": index,
                                      "stampApprovalId": teamApprovalController
                                          .teamApproval
                                          .value[index]
                                          .stampApprovalId,
                                      "approval": true,
                                      "reason": ''
                                    };
                                    teamApprovalController.approvalButton(
                                        data, teamApprovalController);

                                    // Get.toNamed('/NavigationBarDemo1', arguments: 1);
                                  },
                                ),
                              )),
                            ]);
                      })),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
