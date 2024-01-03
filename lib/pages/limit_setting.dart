
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LimitSetting extends StatelessWidget {
  LimitSetting({super.key});

  var data = <dynamic>[
    [false, 'user_account1', 'ユ一步1'],
    [false, 'user_account2', 'ユ一步2'],
  ];

  TextEditingController userAccount = TextEditingController();
  TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if(Get.arguments != null){
      userAccount.text = Get.arguments['userAccount'].toString();
      userName.text = Get.arguments['userName'].toString();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 8, spreadRadius: 1)
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '權限設定',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'User Account: ',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          controller: userAccount ,
                          readOnly: true,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder()),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'User Name : ',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          readOnly: true,
                          controller: userName,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder()),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '修正權限',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '個別設定:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
                      hintText: 'なし',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))
                  ),
                  dropDownList: const [
                    DropDownValueModel(name: '個別設定1', value: '1'),
                    DropDownValueModel(name: '個別設定2', value: '2'),
                    DropDownValueModel(name: '個別設定3', value: '3'),
                    DropDownValueModel(name: '個別設定4', value: '4'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '一括設定:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
                      hintText: 'なし',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  dropDownList: const [
                    DropDownValueModel(name: '一括設定1', value: '1'),
                    DropDownValueModel(name: '一括設定2', value: '2'),
                    DropDownValueModel(name: '一括設定3', value: '3'),
                    DropDownValueModel(name: '一括設定4', value: '4'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '承認權限',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '個別設定:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
                      hintText: 'なし',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  dropDownList: const [
                    DropDownValueModel(name: '個別設定1', value: '1'),
                    DropDownValueModel(name: '個別設定2', value: '2'),
                    DropDownValueModel(name: '個別設定3', value: '3'),
                    DropDownValueModel(name: '個別設定4', value: '4'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '一括設定:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
                      hintText: 'なし',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  dropDownList: const [
                    DropDownValueModel(name: '一括設定1', value: '1'),
                    DropDownValueModel(name: '一括設定2', value: '2'),
                    DropDownValueModel(name: '一括設定3', value: '3'),
                    DropDownValueModel(name: '一括設定4', value: '4'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '複数の承認者を設定',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey),
                        columns: const [
                          DataColumn(label: Expanded(child: Text('選択'))),
                          DataColumn(
                              label: Expanded(child: Text('User Account'))),
                          DataColumn(label: Expanded(child: Text('User Name')))
                        ],
                        rows: List.generate(
                            data.length,(index) {
                          bool selected = data[index][0];
                          var isCheck = selected.obs;
                          return
                            DataRow(
                              cells: [
                                DataCell(
                                  Obx(
                                        () => Checkbox(
                                      value: isCheck.value,
                                      onChanged: (bool? value) {
                                        isCheck.value = value!;
                                      },
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    data[index][1].toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    data[index][2].toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );}
                        ))),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Thành Công', 'Bạn đã cài đặt thành công',
                          backgroundColor: Colors.green);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: Colors.lightBlue,
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                    child: const Text(
                      '保存',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
