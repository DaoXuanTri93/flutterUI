import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/controller/OfficeController.dart';

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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                    SizedBox(
                      width: 70,
                      height: 40,
                      child: ElevatedButton(
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
                        child: Text('検索'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.black))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          final Office offices = Office.create();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OfficeDetails(office: offices)),
                          );
                        },
                        child: Text('新規登録'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.black))),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '検索結果',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                              child: Text(header[index],
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ));
                          }),
                          rows: List.generate(office.length, (index) {
                            return DataRow(
                                cells: [
                                  DataCell(Text('${office[index].baseName}')),
                                  DataCell(Text('${office[index].address}')),
                                  DataCell(
                                      Text('${office[index].telephoneNumber}')),
                                  DataCell(Text('${office[index].manager}')),
                                  DataCell(
                                      Text('${office[index].driverInformation}')),
                                  DataCell(Text('${office[index].drivingRoute}')),
                                  DataCell(Text(
                                      '${office[index].vehicleInformation}')),
                                  DataCell(
                                      Text('${office[index].drivingSchedule}'))
                                ],
                                onSelectChanged: (value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OfficeDetails(
                                                office: office[index],
                                              )));
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
