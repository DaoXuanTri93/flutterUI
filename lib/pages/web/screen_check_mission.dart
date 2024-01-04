import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:login_app/controller/screenCheckMissionController.dart';
import 'package:login_app/controller/teamApprovalController.dart';

class ScreenCheckMission extends StatelessWidget {
  ScreenCheckMission({super.key});

  final CheckMissionController checkMissionController =
      Get.put(CheckMissionController());

  TextEditingController userName = TextEditingController();
  TextEditingController startDay = TextEditingController();
  TextEditingController endDay = TextEditingController();
  var statusMission = ''.obs;
  double sizeHeight = 5;

  late Map<String, dynamic> dataSearch;

  List<String> team = [
    '#',
    'User Name',
    'Start Day',
    'End Day',
    'Status Mission',
    ''
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
              const Text('SEARCH MISSIONAPPROVAL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              const Text('User Name:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: sizeHeight),
              TextField(
                controller: userName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: sizeHeight),
              const Text('Start Day:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: sizeHeight),
              TextField(
                controller: startDay,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "yyyy/mm/dd"),
                onTap: () async {
                  DateTime? datepicker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  startDay.text = DateFormat('yyyy/MM/dd ').format(datepicker!);
                },
              ),
              SizedBox(height: sizeHeight),
              const Text('End Day:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: sizeHeight),
              TextField(
                controller: endDay,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "yyyy/mm/dd"),
                onTap: () async {
                  DateTime? datepicker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  endDay.text = DateFormat('yyyy/MM/dd ').format(datepicker!);
                },
              ),
              SizedBox(height: sizeHeight),
              const Text('Status Mission:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: sizeHeight),
              DropDownTextField(
                textFieldDecoration:
                    const InputDecoration(border: OutlineInputBorder()),
                dropDownList: List.generate(
                    checkMissionController.missionStatusUnique.value.length,
                    (index) {
                  return DropDownValueModel(
                      name: checkMissionController
                          .missionStatusUnique.value[index].statusMission,
                      value: checkMissionController
                          .missionStatusUnique.value[index].statusMission);
                }),
                controller: controller,
                onChanged: (value) {
                  controller.dropDownValue == null
                      ? statusMission.value = ''
                      : statusMission.value = controller.dropDownValue!.name;
                },
              ),
              SizedBox(height: sizeHeight),
              ElevatedButton(
                onPressed: () {
                  dataSearch = {
                    "userName": userName.text,
                    "startDay": startDay.text,
                    "endDay": endDay.text,
                    "statusMission": statusMission.value,
                  };

                  checkMissionController.dataSearch(dataSearch);
                },
                child: Text("検索",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(2))),
              ),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: DataTable(
                      columns: team
                          .map((e) => DataColumn(
                                  label: Expanded(
                                      child: Center(
                                          child: Text(
                                e,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )))))
                          .toList(),
                      rows: List.generate(
                          checkMissionController.dataMission.value.length,
                          (index) {
                        return DataRow(
                            cells: [
                          DataCell(Center(child: Text((index + 1).toString()))),
                          DataCell(Center(
                              child: Text(checkMissionController
                                  .dataMission[index].userName
                                  .toString()))),
                          DataCell(Center(
                              child: Text(checkMissionController
                                  .dataMission[index].startDay
                                  .toString()))),
                          DataCell(Center(
                              child: Text(checkMissionController
                                  .dataMission[index].endDay
                                  .toString()))),
                          DataCell(Center(
                              child: Text(checkMissionController
                                  .dataMission[index].statusMission
                                  .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, color: (checkMissionController
                                    .dataMission[index].statusMission
                                    .toString() == "APPROVED")? Colors.green : (checkMissionController
                                    .dataMission[index].statusMission
                                    .toString() == "REFUSE") ?Colors.red : Colors.black87)
                              ))),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text("APPROVED"),
                                  onPressed: ((checkMissionController
                                                  .dataMission[index]
                                                  .statusMission !=
                                              'WAITING CONFIRM') &&
                                          (checkMissionController
                                                  .dataMission[index]
                                                  .statusMission !=
                                              'PENDING'))
                                      ? null
                                      : () {
                                          checkMissionController
                                              .approvalMission(
                                                  checkMissionController
                                                      .dataMission[index].id);
                                        },
                                  style: ButtonStyle(backgroundColor: (
                                      (checkMissionController.dataMission[index].statusMission != 'WAITING CONFIRM') &&
                                          (checkMissionController.dataMission[index].statusMission != 'PENDING')) ?
                                  MaterialStateProperty.all(Colors.grey):
                                  MaterialStateProperty.all(Colors.green)),
                                ),
                                SizedBox(width: sizeHeight),
                                ElevatedButton(
                                  child: Text("REFUSE"),
                                  onPressed: ((checkMissionController
                                                  .dataMission[index]
                                                  .statusMission !=
                                              'WAITING CONFIRM') &&
                                          (checkMissionController
                                                  .dataMission[index]
                                                  .statusMission !=
                                              'PENDING'))
                                      ? null
                                      : () {
                                          checkMissionController.refuseMission(
                                              checkMissionController
                                                  .dataMission[index].id);
                                        },
                                  style: ButtonStyle(backgroundColor: (
                                      (checkMissionController.dataMission[index].statusMission != 'WAITING CONFIRM') &&
                                          (checkMissionController.dataMission[index].statusMission != 'PENDING')) ?
                                  MaterialStateProperty.all(Colors.grey):
                                  MaterialStateProperty.all(Colors.red)),
                                ),
                              ],
                            ),
                          ),
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
