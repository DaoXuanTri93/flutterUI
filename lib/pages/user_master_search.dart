import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_app/const/fontText.dart';
import '../controller/officeUserController.dart';
import '../controller/staffUserController.dart';
import '../model/staffModel.dart';

class UserMasterSearch extends StatelessWidget {
  UserMasterSearch({super.key});

  var affiliatedOffice = ''.obs;
  var role = ''.obs;
  var userName = ''.obs;

  SingleValueDropDownController dropDownController =
      SingleValueDropDownController();
  final controllerStaffUser =
  Get.put<StaffUserController>(StaffUserController());
  final controllerOfficeUser =
  Get.put<OfficeUserController>(OfficeUserController());


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dataSearch;
    controllerStaffUser.getAllStaffUser();
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
               Text(
                'ユーザマスタ検索',
                style: textFont.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
               Text(
                '事務所:',
                style: textFont.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => DropDownTextField(
                  dropdownRadius: 5,
                  controller: dropDownController,
                  onChanged: (value) {
                    dropDownController.dropDownValue?.name == null
                        ? affiliatedOffice.value = ''
                        : affiliatedOffice.value =
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
                  dropDownList: controllerOfficeUser.officeUserList.value
                      .map(
                        (e) => DropDownValueModel(
                            name: e.baseName!, value: e.officeId),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
               Text(
                '種別:',
                 style: textFont.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              DropDownTextField(
                  dropdownRadius: 5,
                  controller: dropDownController,
                  onChanged: (value) {
                    dropDownController.dropDownValue?.name == null
                        ? role.value = ''
                        : role.value = dropDownController.dropDownValue!.name;
                  },
                  dropDownIconProperty: IconProperty(
                      color: Colors.black,
                      size: 30,
                      icon: Icons.keyboard_arrow_down),
                  textFieldDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  dropDownList: const [
                    DropDownValueModel(name: 'admin', value: 'admin'),
                    DropDownValueModel(name: 'member', value: 'member'),
                    DropDownValueModel(name: 'DRIVER', value: 'DRIVER'),
                  ]),
              const SizedBox(
                height: 10,
              ),
               Text(
                '名前:',
                 style: textFont.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  userName.value = value;
                },
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
                      dataSearch = {
                        'affiliatedOffice': affiliatedOffice,
                        'role': role,
                        'userName': userName
                      };
                      controllerStaffUser.searchStaffUser(dataSearch);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      '検索',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        const id = null;
                        Get.toNamed('/users-details', arguments: id);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          backgroundColor: Colors.blue),
                      child: const Text(
                        '新規登録',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,),
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
               Text(
                '検索結果',
                style: textFont.titleMedium,
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() => controllerStaffUser.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        // columnSpacing: 20,

                        headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey.shade300),
                        columns: [
                          DataColumn(
                              label: Expanded(child: Center(child: Text('事務所', style: textFont.titleSmall,)))),
                          DataColumn(
                              label: Expanded(child: Center(child: Text('種別', style: textFont.titleSmall)))),
                          DataColumn(
                              label: Expanded(child: Center(child: Text('名前', style: textFont.titleSmall)))),
                        ],
                        rows: controllerStaffUser.staffUserList
                            .map(
                              (e) => DataRow(cells: [
                                DataCell(Center(
                                  child: Text(
                                    e.affiliatedOffice,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                                DataCell(Center(
                                  child: Text(e.role,
                                      overflow: TextOverflow.ellipsis),
                                )),
                                DataCell(Center(
                                  child: InkWell(
                                      onTap: () {
                                        controllerStaffUser.getAllStaffUserDetail(
                                            e.id.toString());
                                        // Get.toNamed('/users-details',arguments: e.id);
                                      },
                                      child: Text(e.userName,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.blue))),
                                ))
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
