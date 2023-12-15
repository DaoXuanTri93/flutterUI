import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/staffuserController.dart';
import '../model/staffmodel.dart';

class UserMasterSearch extends StatelessWidget {
  UserMasterSearch({super.key});

  List child = [
    [
      '提点1',
      '住所1',
      '電話番号1',
      '012-345-6789',
    ],
    [
      '提点2',
      '住所2',
      '電話番号2',
      '012-345-6789',
    ],
    [
      '提点3',
      '住所3',
      '電話番号3',
      '012-345-6789',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<StaffUserController>(StaffUserController());
    List<StaffUser> listStaffUser = controller.staffUserList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'ユーザマスタ検索',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '事務所:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              DropDownTextField(
                dropdownRadius: 5,
                dropDownIconProperty: IconProperty(
                    color: Colors.black,
                    size: 30,
                    icon: Icons.keyboard_arrow_down),
                textFieldDecoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                dropDownList: child
                    .map(
                      (e) => DropDownValueModel(name: e[0], value: e[0]),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '種別:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              DropDownTextField(
                dropdownRadius: 5,
                dropDownIconProperty: IconProperty(
                    color: Colors.black,
                    size: 30,
                    icon: Icons.keyboard_arrow_down),
                textFieldDecoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                dropDownList: child
                    .map(
                      (e) => DropDownValueModel(name: e[1], value: e[1]),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '名前:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('DriverInfo');
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      backgroundColor: Colors.grey[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      '検索',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          backgroundColor: Colors.lightBlue),
                      child: const Text(
                        '新規登録',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                '検索結果',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        headingRowColor:
                            MaterialStateColor.resolveWith((states) {
                          return Colors.grey;
                        }),
                        columns: const <DataColumn>[
                          DataColumn(
                              label: Expanded(
                            child: Text('事務所'),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text('種別'),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text('名前'),
                          )),
                        ],
                        rows: listStaffUser
                            .map(
                              (e) => DataRow(cells: [
                                DataCell(Text(
                                  e.affiliatedOffice.baseName,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                DataCell(Text(e.userAccount.role,
                                    overflow: TextOverflow.ellipsis)),
                                DataCell(InkWell(
                                    onTap: () {
                                      // Get.toNamed('/UserMasterDetails',arguments: e);
                                    },
                                    child: Text(e.userName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue))))
                              ]),
                            )
                            .toList(),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
