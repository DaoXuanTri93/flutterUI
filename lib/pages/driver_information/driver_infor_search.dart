import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/services/uploadCalendar.dart';

import '../../const/font_text.dart';
import '../../controller/staff_controller.dart';

class DriverInforSearch extends StatelessWidget {
  DriverInforSearch({super.key});

  var notStamped = false.obs;
  var businessTrip = false.obs;
  final List titleTable = [
    '事務所',
    '運転手名',
    '日付',
    'エリア',
    '出勤打刻時間',
    '退勤打 刻時間',
    '所定時間外出勤時間',
    '所定時間外退勤時間',
    '出張有無',
    '距離',
    'メータ ーリン ク',
  ];

  final List<List<String>> childTable = [
    ['事務所1', '運転手A', '2023-01-01','エリアA', '08:00', '17:00', '1:00',
      '0:00', 'あり', '50km', '詳細', '001', '17/07/2000', '0123456789'],
  ];

  String? selectedOffice;

  final List officeItem = [
    'すべての事務所',
    'office 1',
    'office 2',
    'office 4',
    'office 5',
  ].obs;

  @override
  Widget build(BuildContext context) {

    final StaffController controller = Get.put(StaffController());
    final TextEditingController searchController = TextEditingController();
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text('運転手情報検索', style: TextFont.textFont.titleLarge,),
                  ),

                  /// Search

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('事務所 :',style: TextFont.textFont.titleMedium,),
                            ),
                            Obx(
                              () => DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                value: selectedOffice,
                                onChanged: (value) {
                                },
                                items: officeItem.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('運転手名 :',style: TextFont.textFont.titleMedium,),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  // hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('日付 :',style: TextFont.textFont.titleMedium,),
                            ),
                            UpLoadCalendar(),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('エリ ア :',style: TextFont.textFont.titleMedium,),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero)),
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('未打刻 :',style: TextFont.textFont.titleMedium),
                  ),
                  Center(
                    child: Obx(
                      () => Checkbox(
                        value: notStamped.value,
                        onChanged: (bool? value) {
                          notStamped.value =! notStamped.value;
                        },),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('出張有無 :',style: TextFont.textFont.titleMedium),
                  ),
                  Center(
                    child: Obx(
                          () => Checkbox(
                        value: businessTrip.value,
                        onChanged: (bool? value) {
                          businessTrip.value =! businessTrip.value;
                        },),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {controller.search(searchController.text);},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[350],
                          foregroundColor: Colors.black,
                          shape: const BeveledRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Colors.black,width: 0.3)
                          )
                      ),
                      child: const Text('検索')
                  ),
                  /// Find

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child:DataTable(
                          border: TableBorder.all(width: 0.3, style: BorderStyle.solid),
                          headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey.shade200),
                          columns: titleTable.map(
                                  (title) =>
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(title, style: TextFont.textFont.titleSmall)
                                      )
                                  )
                          ).toList(),
                          rows: childTable.map(
                                  (rowData) {
                                return DataRow(
                                  cells:[
                                    DataCell(Expanded(child: Text(rowData[0]))),
                                    DataCell(Expanded(child: Text(rowData[1]))),
                                    DataCell(Expanded(child: Text(rowData[2]))),
                                    DataCell(Expanded(child: Text(rowData[3]))),
                                    DataCell(Expanded(child: Text(rowData[4]))),
                                    DataCell(Expanded(child: Text(rowData[5]))),
                                    DataCell(Expanded(child: Text(rowData[6]))),
                                    DataCell(Expanded(child: Text(rowData[7]))),
                                    DataCell(Expanded(child: Text(rowData[8]))),
                                    DataCell(Expanded(child: Text(rowData[9]))),
                                    DataCell(
                                        onTap: () {
                                          Get.toNamed('/driver-infor-details', arguments: rowData);
                                        },
                                        Text(rowData[10],
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline
                                          ),
                                        )
                                    ),
                                  ],
                                );
                              }).toList(),
                        )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2)
                        )
                    ),
                    child: const Text('CSV出力'),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
