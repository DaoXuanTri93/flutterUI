import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:login_app/const/fontText.dart';
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
            // scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('運転手情報検索', style: textFont.titleLarge,),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('事務所 :', style: textFont.titleMedium,),
                          ), DropDownTextField(
                            dropdownRadius: 5,
                            controller: dropDownController,
                            onChanged: (value) {
                              dropDownController.dropDownValue?.name == null
                                  ? affiliatedOfficeController.text = ''
                                  : affiliatedOfficeController.text =
                                  dropDownController.dropDownValue!.name;
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '運転手名 :', style: textFont.titleMedium,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              userNameController.text = value;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                '日付 :',
                                style: textFont.titleMedium
                            ),
                          ),
                          TextField(
                            controller: submissionDate,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'yyyy/mm/dd',
                                suffixIcon: Icon(Icons.calendar_today)),
                            onTap: () async {
                              DateTime? datepicker = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100));
                              submissionDate.text =
                                  DateFormat('yyyy/MM/dd ').format(datepicker!) ;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'エリア :'
                                ,style: textFont.titleMedium),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              areaController.text = value;
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('未打刻 :',style: textFont.titleMedium),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      '出張有無 :',
                      style: textFont.titleMedium),
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
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.black,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.black, width: 0.3))),
                    child: const Text('検索',style: TextStyle(color: Colors.white),)),

                /// Find

                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        return DataTable(
                          columnSpacing: 20,
                            border: TableBorder.all(
                                width: 0.3, style: BorderStyle.solid),
                            headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.grey.shade200),
                            columns: List.generate(titleTable.length, (index) {
                              return DataColumn(
                                  label:
                                  Expanded(child: Center(
                                    child: Text(titleTable[index],
                                        style: textFont.titleSmall),
                                  )));
                            }),
                            rows: List.generate(
                                driverController.driverList.length, (index) {
                              return DataRow(
                                cells: [
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]['officeName']?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]['userName']?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]['dayTimeKeeping']?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]['area']?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]['timeStartDay']?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]['timeEndDay']?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]["overTimeStart"]?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]["overTimeEnd"]?? '-'}'),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        driverController.driverList[index]['workOutside'] ? 'あり' : 'ない',
                                      style: TextStyle(
                                          color: (driverController.driverList[index]['workOutside'] ? Colors.green : Colors.red),
                                          fontWeight: FontWeight.bold),),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                        '${driverController.driverList[index]["totalDistance"]?? '0'} km', overflow: TextOverflow.ellipsis,),
                                  )
                                  ),
                                  DataCell(onTap: () {
                                    Get.toNamed('/driver-infor-detail/${driverController.driverList[index]['id']}');
                                  },
                                      Center(
                                        child: const Text(
                                          '詳細',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline),
                                        ),
                                      )),
                                ],
                              );
                            }));
                      }),
                    )),
                ElevatedButton(
                  onPressed: () {
                    driverController.exportToExcel();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  child: const Text('CSV出力',style: TextStyle(color: Colors.white),),
                )
              ]),
            ),
          )),
    );
  }
}