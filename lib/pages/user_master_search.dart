import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_app/model/officemodel.dart';

import '../controller/officeUserController.dart';
import '../controller/searchUserController.dart';
import '../controller/staffuserController.dart';
import '../model/staffmodel.dart';
import '../model/usermodel.dart';

class UserMasterSearch extends StatelessWidget {
   UserMasterSearch({super.key});

  var affiliatedOffice = ''.obs;
  var role = ''.obs;
  var userName = ''.obs;

  SingleValueDropDownController dropDownController = SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    final controllerStaffUser = Get.put<StaffUserController>(StaffUserController());
    final controllerOfficeUser = Get.put<OfficeUserController>(OfficeUserController());
    final controllerSearchUser = Get.put<SearchUserController>(SearchUserController());

    List<StaffUser> listStaffUser = controllerStaffUser.staffUserList;
    List<OfficeUser> listOfficeUser = controllerOfficeUser.officeUserList;
    List<SearchUser> searchUser = controllerSearchUser.searchUserList;

    Map<String, dynamic> dataSearch;

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
                controller: dropDownController,
                onChanged: (value){
                  dropDownController.dropDownValue?.name == null ?
                  affiliatedOffice.value = '' :
                  affiliatedOffice.value = dropDownController.dropDownValue!.name;
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
                          name: e.baseName, value: e.baseName),
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
                controller: dropDownController,
                onChanged: (value){
                  dropDownController.dropDownValue?.name == null ?
                  role.value = '' :
                  role.value = dropDownController.dropDownValue!.name;
                },
                dropDownIconProperty: IconProperty(
                    color: Colors.black,
                    size: 30,
                    icon: Icons.keyboard_arrow_down),
                textFieldDecoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                dropDownList: searchUser
                    .map(
                      (e) => DropDownValueModel(name: e.role, value: e.role),
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
                onChanged: (value){
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
                      controllerStaffUser.getAllOffice(dataSearch);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
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
                      onPressed: () {

                      },
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
              Obx(() => controllerStaffUser.isLoading.value
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
                                  e.affiliatedOffice,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                DataCell(Text(e.role,
                                    overflow: TextOverflow.ellipsis)),
                                DataCell(InkWell(
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
