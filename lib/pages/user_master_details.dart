import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mac_address/mac_address.dart';
import '../controller/officeUserController.dart';
import '../controller/staffUserController.dart';
import '../model/officeModel.dart';
import '../model/staffModel.dart';

class UserMasterDetails extends StatelessWidget {
  UserMasterDetails({super.key});

  final TextEditingController userAccount = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController mail = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController mac = TextEditingController();
  final TextEditingController affiliatedOffice = TextEditingController();
  final _role = ''.obs;
  SingleValueDropDownController dropDownController =
      SingleValueDropDownController();
  var dropdownValue = ''.obs;

  @override
  Widget build(BuildContext context) {
    final StaffUserController controllerStaffUser =
        Get.put(StaffUserController());

    final controllerOfficeUser =
        Get.put<OfficeUserController>(OfficeUserController());

    if (Get.arguments != null) {
      for (var element in controllerStaffUser.staffUserListDetail) {
        userAccount.text = element.userAccount.toString();
        userName.text = element.userName.toString();
        mail.text = element.email.toString();
        phone.text = element.telephone.toString();
        mac.text = 'MAC : ${element.mac.toString()}';
        dropdownValue.value =
            affiliatedOffice.text = element.affiliatedOffice.toString();
        _role.value = element.role;
      }
    } else {
      userAccount.text = '';
      userName.text = '';
      mail.text = '';
      phone.text = '';
      mac.text = 'MAC : ';
      dropdownValue.value = '';
      _role.value = '';
    }

    List<OfficeUser> listOfficeUser = controllerOfficeUser.officeUserList;

    return Obx(() => controllerStaffUser.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 1, blurRadius: 8)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ユーザマスタ詳細',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 60,
                            width: 220,
                            child: TextFormField(
                              readOnly: true,
                              controller: mac,
                              style: const TextStyle(color: Colors.grey),
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'User Account :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: userAccount,
                        decoration: const InputDecoration(
                            hintText: 'User Account',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'User Name :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: userName,
                        decoration: const InputDecoration(
                            hintText: 'User Name',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Mail :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: mail,
                        decoration: const InputDecoration(
                            hintText: 'Mail',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '電話番号 :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(
                            hintText: 'Phone',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '所属事務所 :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropDownTextField(
                        dropdownRadius: 5,
                        controller: dropDownController,
                        onChanged: (value) {
                          dropDownController.dropDownValue?.name == null
                              ? affiliatedOffice.text = dropdownValue.value
                              : affiliatedOffice.text =
                                  dropDownController.dropDownValue!.name;
                        },
                        dropDownIconProperty: IconProperty(
                            color: Colors.black,
                            size: 30,
                            icon: Icons.keyboard_arrow_down),
                        textFieldDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: affiliatedOffice.text,
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
                      Obx(
                        () => Row(
                          children: [
                            const Text('ユーザ種別 :',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Radio(
                              value: 'DRIVER',
                              groupValue: _role.value,
                              onChanged: (value) {
                                _role.value = value!;
                              },
                            ),
                            const Text('運転手',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Radio(
                              value: 'member',
                              groupValue: _role.value,
                              onChanged: (value) {
                                _role.value = value!;
                              },
                            ),
                            const Text('営業スタッフ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Radio(
                              value: 'admin',
                              groupValue: _role.value,
                              onChanged: (value) {
                                _role.value = value!;
                              },
                            ),
                            const Text('管理者',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Get.arguments != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      StaffUser staffUser = StaffUser(
                                          id: 0,
                                          userAccount: userAccount.text,
                                          userName: userName.text,
                                          email: mail.text,
                                          telephone: phone.text,
                                          affiliatedOffice:
                                              affiliatedOffice.text,
                                          role: _role.value,
                                          mac: mac.text);
                                      controllerStaffUser.updateStaffUser(
                                          Get.arguments.toString(), staffUser);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        backgroundColor: Colors.lightBlue),
                                    child: const Text(
                                      '編集',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed('/limit-setting',arguments: Get.arguments);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        backgroundColor: Colors.lightBlue),
                                    child: const Text(
                                      '権限設定',
                                      style: TextStyle(color: Colors.white),
                                    )
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      StaffUser staffUser = StaffUser(
                                          id: 0,
                                          userAccount: userAccount.text,
                                          userName: userName.text,
                                          email: mail.text,
                                          telephone: phone.text,
                                          affiliatedOffice:
                                              affiliatedOffice.text,
                                          role: _role.value,
                                          mac: mac.text);

                                      controllerStaffUser
                                          .createStaffUser(staffUser);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        backgroundColor: Colors.lightBlue),
                                    child: const Text(
                                      '新規登録',
                                      style: TextStyle(color: Colors.white),
                                    )
                                ),
                              ],
                          )
                    ],
                  ),
                ),
              ),
            ),
        )
    );
  }
}
