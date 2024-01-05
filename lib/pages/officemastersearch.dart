import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/const/fontText.dart';
import 'package:login_app/controller/officeController.dart';

import '../model/office.dart';
import 'officemasterdetails.dart';

class OfficeMasterSearch extends StatelessWidget {
  OfficeMasterSearch({super.key});
  var header = ['提点名', '住所', '電話番号', '管理者', '運転手情報', '運転ルート', '車両情報', '運転日程'];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<OfficeController>(OfficeController());
    final baseName = TextEditingController();
    final address = TextEditingController();
    final telephoneNumber = TextEditingController();
    final manager = TextEditingController();
    final driverInformation = TextEditingController();
    final drivingRoute = TextEditingController();
    final vehicleInformation = TextEditingController();
    final drivingSchedule = TextEditingController();
    return Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '事務所マスタ検索',
                  style: textFont.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '提点名',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: baseName,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '住所',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: address,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '電話番号',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: telephoneNumber,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '管理者',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: manager,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '運転手情報',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: driverInformation,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '運転ルート',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: drivingRoute,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '車両情報',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: vehicleInformation,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '運転日程',
                              overflow: TextOverflow.ellipsis,
                              style: textFont.titleMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: drivingSchedule,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.zero),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final offices = Office.search(
                            baseName.value.text,
                            address.value.text,
                            telephoneNumber.value.text,
                            manager.value.text,
                            driverInformation.value.text,
                            drivingRoute.value.text,
                            vehicleInformation.value.text,
                            drivingSchedule.value.text);
                        controller.searchListOffice(offices);
                      },
                      child: Text('検索',style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/officedetails/');
                      },
                      child: Text('新規登録',style: TextStyle(color: Colors.white),),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '検索結果',
                  style: textFont.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Obx(
                      () {
                        final office = controller.searchOfficeList;
                        return DataTable(
                          showCheckboxColumn: false,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey.shade300),
                          columns: List.generate(header.length, (index) {
                            return DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text(header[index],
                                  style: textFont.titleMedium),
                              ),
                            ));
                          }),
                          rows: List.generate(office.length, (index) {
                            return DataRow(
                                cells: [
                                  DataCell(Center(child: Text(office[index].baseName ?? '-'))),
                                  DataCell(Center(child: Text(office[index].address ?? '-'))),
                                  DataCell(
                                      Center(child: Text(office[index].telephoneNumber ?? '-'))),
                                  DataCell(Center(child: Text(office[index].manager ?? '-'))),
                                  DataCell(
                                      Center(child: Text(office[index].driverInformation ?? '-'))),
                                  DataCell(Center(child: Text(office[index].drivingRoute ?? '-'))),
                                  DataCell(Center(
                                    child: Text(
                                        office[index].vehicleInformation ?? '-'),
                                  )),
                                  DataCell(
                                      Center(child: Text(office[index].drivingSchedule ?? '-')))
                                ],
                                onSelectChanged: (value) {
                                  Get.toNamed('/officedetails/${office[index].officeId.toString()}');
                                });
                          }),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
