import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:login_app/controller/driverController.dart';

class DriverInforSearch extends StatelessWidget {
  DriverInforSearch({super.key});

  final notStamped = false.obs;
  final businessTrips = false.obs;
  final titleTable = [
    '事務所',
    '運転手名',
    '日付',
    'エリア',
    '出勤打刻時間',
    '退勤打刻時間',
    '所定時間外出勤時間',
    '所定時間外退勤時間',
    '出張有無',
    '距離',
    'メーターリンク',
  ];

  SingleValueDropDownController dropDownController =
      SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dataSearch;

    DriverController driverController = Get.put(DriverController());

    TextEditingController affiliatedOfficeController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController areaController = TextEditingController();

    TextEditingController submissionDate = TextEditingController();

    final seen = Set<String>();
    List<dynamic> uniquelist = driverController.driverList
        .where((country) => seen.add(country["officeName"]))
        .toList();
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('運転手情報検索'),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('事務所 :'),
                      ), DropDownTextField(
                          dropdownRadius: 5,
                          controller: dropDownController,
                          onChanged: (value) {
                            dropDownController.dropDownValue?.name == null
                                ? affiliatedOfficeController.text = ''
                                : affiliatedOfficeController.text =
                                    dropDownController.dropDownValue!.name;
                            // print(affiliatedOfficeController.text);
                          },
                          dropDownIconProperty: IconProperty(
                              color: Colors.black,
                              size: 30,
                              icon: Icons.keyboard_arrow_down),
                          textFieldDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          dropDownList: uniquelist
                              .map(
                                (e) => DropDownValueModel(
                                    name: e["officeName"], value: e["officeName"]),
                              )
                              .toList(),
                        ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '運転手名 :',
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          userNameController.text = value;
                        },
                        decoration: const InputDecoration(
                            // hintStyle: TextStyle(color: Colors.grey),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero)),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '日付 :',
                        ),
                      ),
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('エリア :'),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          areaController.text = value;
                          // print(areaController.text);
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('未打刻 :'),
            ),
            Center(
              child: Obx(
                () => Checkbox(
                  value: notStamped.value,
                  onChanged: (bool? value) {
                    notStamped.value = !notStamped.value;
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('出張有無 :'),
            ),
            Center(
              child: Obx(
                () => Checkbox(
                  value: businessTrips.value,
                  onChanged: (bool? value) {
                    businessTrips.value = !businessTrips.value;
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 5,
            ),
            ///---------
            ElevatedButton(
                onPressed: () {
                  dataSearch = {
                    'affiliatedOffice': affiliatedOfficeController.text,
                    'userName': userNameController.text,
                    'date': submissionDate.text,
                    'area': areaController.text,
                    'not-stamped': notStamped.value,
                    'businessTrip': businessTrips.value
                  };
                  driverController.dataSearch(dataSearch);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[350],
                    foregroundColor: Colors.black,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.black, width: 0.3))),
                child: const Text('検索')),

            /// Find

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Obx(() {
                      return DataTable(
                          border: TableBorder.all(
                              width: 0.3, style: BorderStyle.solid),
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey.shade200),
                          columns: List.generate(titleTable.length, (index) {
                            return DataColumn(
                                label:
                                    Expanded(child: Text(titleTable[index])));
                          }),
                          rows: List.generate(
                              driverController.driverList.length, (index) {
                            return DataRow(
                              cells: [
                                DataCell(Text(
                                    '${driverController.driverList[index]['officeName']}')),
                                DataCell(
                                    onTap: () {},
                                    Text(driverController
                                        .driverList[index]['userName']
                                        .toString())),
                                DataCell(Text(
                                    '${driverController.driverList[index]['dayTimeKeeping']}')),
                                DataCell(Text(
                                    '${driverController.driverList[index]['area']}')),
                                DataCell(Text(
                                    '${driverController.driverList[index]['timeStartDay']}')),
                                DataCell(Text(
                                    '${driverController.driverList[index]['timeEndDay']}')),
                                DataCell(Text(
                                    '${driverController.driverList[index]["overTimeStart"]}')),
                                DataCell(Text(
                                    '${driverController.driverList[index]["overTimeEnd"]}')),
                                DataCell(Text(
                                    '${driverController.driverList[index]['workOutside']}')),
                                DataCell(Text(
                                    '${driverController.driverList[index]["totalDistance"]}')),
                                DataCell(onTap: () {
                                  Get.toNamed('/driver-infor-detail/${driverController.driverList[index]['id']}');
                                },
                                    const Text(
                                      '詳細',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                    )),
                              ],
                            );
                          }));
                    }),
                  ),
                )),
            ElevatedButton(
              onPressed: () {
                driverController.exportToExcel();
              },
              style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2))),
              child: const Text('CSV出力'),
            )
          ]),
        ),
      )),
    );
  }
}
