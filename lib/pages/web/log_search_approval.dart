import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:login_app/const/fontText.dart';
import 'package:login_app/controller/teamApprovalController.dart';
import '../../../controller/log_controller.dart';

class LogSearch extends StatelessWidget {
  LogSearch({super.key});
  final TeamApprovalController teamApprovalController =
  Get.put<TeamApprovalController>(TeamApprovalController());

  var isApproval = false.obs;
  final List titleTable = [
    '事務所',
    '種別',
    '操作者名',
    '日付',
    '種類',
    '操作時間',
  ];

  @override
  Widget build(BuildContext context) {
    Map<String , dynamic> dataSearch ;
    TextEditingController datetime = TextEditingController();
    LogController controllerLog = Get.put(LogController());
    TextEditingController affiliatedOfficeController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController operatorNameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController kindsController = TextEditingController();
    TextEditingController operationTimeController = TextEditingController();
    SingleValueDropDownController dropDownController = SingleValueDropDownController();
    List listOfficeUser = controllerLog.officeUserList;
    final log = controllerLog.searchLogList;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('ログ検索', style: textFont.titleLarge),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('事務所 :',style: textFont.titleMedium),
                            ),
                            Obx(
                                  () =>
                                  DropDownTextField(
                                    dropdownRadius: 5,
                                    controller: dropDownController,
                                    onChanged: (value){
                                      dropDownController.dropDownValue?.name == null ?
                                      affiliatedOfficeController.text = '' :
                                      affiliatedOfficeController.text = dropDownController.dropDownValue!.name;
                                    },
                                    dropDownIconProperty: IconProperty(
                                        color: Colors.black,
                                        size: 30,
                                        icon: Icons.keyboard_arrow_down),
                                    textFieldDecoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5))),
                                    dropDownList: listOfficeUser
                                        .map(
                                          (e) => DropDownValueModel(
                                          name: e.affiliatedOffice, value: e.affiliatedOffice),
                                    )
                                        .toList(),
                                  ),
                            ),
                             Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('種別 :',style: textFont.titleMedium),
                            ),
                            Obx(
                                  () =>
                                  DropDownTextField(
                                    dropdownRadius: 5,
                                    controller: dropDownController,
                                    onChanged: (value){
                                      dropDownController.dropDownValue?.name == null ?
                                      typeController.text = '' :
                                      typeController.text = dropDownController.dropDownValue!.name;
                                      // print(typeController.text);
                                    },
                                    dropDownIconProperty: IconProperty(
                                        color: Colors.black,
                                        size: 30,
                                        icon: Icons.keyboard_arrow_down),
                                    textFieldDecoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5))),
                                    dropDownList: controllerLog.role
                                        .map(
                                          (e) => DropDownValueModel(
                                          name: e.type, value: e.type),
                                    )
                                        .toList(),
                                  ),
                            ),

                             Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('操作者名 :',style: textFont.titleMedium),
                            ),
                            TextFormField(
                              controller: operatorNameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                             Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('日付 :',style: textFont.titleMedium),
                            ),
                            TextFormField(
                              controller: datetime,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Field is required';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                  focusColor: Colors.red,
                                  hintText: 'yyyy/mm/dd',
                                  suffixIcon:
                                  const Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(0))),
                              onTap: () async {
                                DateTime? datepicker = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025));
                                if (datepicker != null) {
                                  datetime.text = DateFormat('yyyy/MM/dd')
                                      .format(datepicker);
                                }
                              },
                            ),
                            const SizedBox(height: 10,),

                             Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('種類 :',style: textFont.titleMedium),
                            ),
                            const SizedBox(height: 10,),
                            Obx(
                                  () =>
                                  DropDownTextField(
                                    dropdownRadius: 5,
                                    controller: dropDownController,
                                    onChanged: (value){
                                      dropDownController.dropDownValue?.name == null ?
                                      kindsController.text = '' :
                                      kindsController.text = dropDownController.dropDownValue!.name;
                                    },
                                    dropDownIconProperty: IconProperty(
                                        color: Colors.black,
                                        size: 30,
                                        icon: Icons.keyboard_arrow_down),
                                    textFieldDecoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5))),
                                    dropDownList: controllerLog.status
                                        .map(
                                          (e) => DropDownValueModel(
                                          name: e.kinds, value: e.kinds),
                                    )
                                        .toList(),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(

                      onPressed: () {
                        dataSearch = {
                          'officeName': affiliatedOfficeController.text,
                          'role': typeController.text,
                          'operatorName': operatorNameController.text,
                          'approvalDay': dateController.text,
                          'status': kindsController.text,
                          'hourApproval': operationTimeController.text
                        };
                        controllerLog.searchListLog(dataSearch);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child:  Text('検索', style: TextStyle(color: Colors.white))
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => DataTable(
                            showCheckboxColumn: false,
                            border: TableBorder.all(width: 0.3, style: BorderStyle.solid),
                            headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.grey.shade200),
                            columns: List.generate(
                                titleTable.length, (index) {
                              return DataColumn(
                                  label: Expanded(
                                      child: Center(child: Text(titleTable[index], style: textFont.titleMedium))
                                  )
                              );
                            }),
                            rows: List.generate(
                                log.length, (index) {
                              return DataRow(
                                onSelectChanged: (selected){
                                  teamApprovalController.showDetailTeamApproval(
                                      teamApprovalController
                                          .teamApproval.value[index].stampApprovalId
                                          .toString());
                                },
                                cells: [
                                  DataCell(Center(child: Text('${log[index].affiliatedOffice}'))),
                                  DataCell(Center(child: Text('${log[index].type}'))),
                                  DataCell(Center(child: Text('${log[index].operatorName}'))),
                                  DataCell(Center(child: Text('${log[index].date}'))),
                                  DataCell(Center(child: Text('${log[index].kinds}'))),
                                  DataCell(Center(child: Text('${log[index].operationTime}'))),
                                ],
                              );
                            })
                          ),
                        )
                    )

                  ),
                ],
              ),
            ),
          )),
    );
  }
}
