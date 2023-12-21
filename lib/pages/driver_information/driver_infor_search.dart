import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/services/uploadCalendar.dart';

import '../../const/font_text.dart';
import '../../controller/staff_controller.dart';
import '../../models/staff_models.dart';


// import 'package:syncfusion_flutter_xlsio/xlsio.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'package:universal_html/html.dart' as AnchorElement;
// import 'package:flutter/foundation.dart' as kIsWeb;

class DriverInforSearch extends StatelessWidget {
  DriverInforSearch({super.key});

  var notStamped = false.obs;
  var businessTrips = false.obs;
  var titleTable = [
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
  // final List<List<String>> childTable = [
  //   ['事務所1', '運転手A', '2023-01-01','エリアA', '08:00', '17:00', '1:00',
  //     '0:00', 'あり', '50km', '詳細', '001', '17/07/2000', '0123456789'],
  // ];

  String? selectedOffice;
  final List officeItem = [
    'すべての事務所',
    '事務所1',
    '事務所2',
    '事務所3',
    '事務所4',
  ].obs;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put<StaffController>(StaffController());


    final affiliatedOffice = TextEditingController();
    final userName = TextEditingController();
    final date = TextEditingController();
    final area = TextEditingController();
    final clockInTime = TextEditingController();
    final clockOutTime = TextEditingController();
    final overtimeClockInTime = TextEditingController();
    final overtimeClockOutTime = TextEditingController();
    final businessTrip = TextEditingController();
    final distance = TextEditingController();
    final meterLink = TextEditingController();

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
                        value: businessTrips.value,
                        onChanged: (bool? value) {
                          businessTrips.value =! businessTrips.value;
                        },),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       final staffsearch = Staff.search(
                  //         affiliatedOffice.value.text,
                  //         userName.value.text,
                  //         date.value.text,
                  //         area.value.text,
                  //         businessTrip.value.text,
                  //       );
                  //       controller.searchListStaff(staffsearch);
                  //       print('object');
                  //       print(Staff);
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.grey[350],
                  //         foregroundColor: Colors.black,
                  //         shape: const BeveledRectangleBorder(
                  //             borderRadius: BorderRadius.zero,
                  //             side: BorderSide(color: Colors.black,width: 0.3)
                  //         )
                  //     ),
                  //     child: const Text('検索')
                  // ),
                  /// Find

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child:SingleChildScrollView(
                          child: Obx(
                            () {
                              final List staff = controller.searchStaffList;

                              return DataTable(
                                  border: TableBorder.all(width: 0.3, style: BorderStyle.solid),
                                  headingRowColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.grey.shade200),
                                  columns: List.generate(titleTable.length, (index) {
                                    return DataColumn(
                                        label: Expanded(
                                            child: Text(titleTable[index], style: TextFont.textFont.titleSmall)
                                        )
                                    );
                                  }),
                                  rows: List.generate(staff.length, (index) {
                                    return DataRow(
                                      cells:[
                                        DataCell(Text('${staff[index].affiliatedOffice}')),
                                        DataCell(onTap: () {
                                          Get.toNamed('/driver-infor-details');
                                        },Text('${staff[index].userName}')),
                                        DataCell(Text('${staff[index].date}')),
                                        DataCell(Text('${staff[index].area}')),
                                        DataCell(Text('${staff[index].clockInTime}')),
                                        DataCell(Text('${staff[index].clockOutTime}')),
                                        DataCell(Text('${staff[index].overtimeClockInTime}')),
                                        DataCell(Text('${staff[index].overtimeClockOutTime}')),
                                        DataCell(Text('${staff[index].businessTrip}')),
                                        DataCell(Text('${staff[index].distance}')),
                                        DataCell(Text('${staff[index].meterLink}',
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  decoration: TextDecoration.underline
                                              ),
                                            )
                                        ),
                                      ],
                                    );
                                  })
                              );
                            }
                          ),
                        ),
                    )),
                  ElevatedButton(
                    onPressed:  () {

                    },
                    style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2)
                        )
                    ),
                    child: const Text('CSV出力'),
                  )
              ]),
            ),
          )),
    );
  }

  // Future<void> createExcel() async {
  //   final Workbook workbook = Workbook();
  //   final Worksheet sheet = workbook.worksheets[0];
  //   sheet.getRangeByName('A1').setText('Hello World!');
  //   final List<int> bytes = workbook.saveAsStream();
  //   workbook.dispose();
  //
  //   if (kIsWeb) {
  //     AnchorElement(
  //         href:
  //         'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
  //       ..setAttribute('download', 'FileTest.xlsx')
  //       ..click();
  //   } else {
  //     final String path = (await getApplicationSupportDirectory()).path;
  //     final String fileName =
  //     Platform.isWindows ? '$path\\FileTest.xlsx' : '$path/FileTest.xlsx';
  //     final File file = File(fileName);
  //     await file.writeAsBytes(bytes, flush: true);
  //     OpenFile.open(fileName);
  //   }
  // }
}
