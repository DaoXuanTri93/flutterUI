import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:text_area/text_area.dart';

import '../controller/OfficeController.dart';
import '../model/office.dart';
import 'officemastersearch.dart';

class OfficeDetails extends StatelessWidget {
  const OfficeDetails({super.key, required this.office});
  final Office office;
  @override
  Widget build(BuildContext context) {
    final TextEditingController baseName =
        TextEditingController(text: office.baseName);
    final TextEditingController address =
        TextEditingController(text: office.address);
    final TextEditingController telephoneNumber =
        TextEditingController(text: office.telephoneNumber);
    final TextEditingController manager =
        TextEditingController(text: office.manager);
    final TextEditingController detailedInformation =
        TextEditingController(text: office.detailedInformation);
    final TextEditingController coordinate =
        TextEditingController(text: office.coordinate);
    final TextEditingController engravingRangeRadius =
        TextEditingController(text: office.engravingRangeRadius);
    final TextEditingController basePhoto =
        TextEditingController(text: office.basePhoto);
    final controller = Get.put<OfficeController>(OfficeController());
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '事務所マスタ詳細',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   '拠点写真:',
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    // ),
                    // Icon(Icons.access_time_filled_sharp)
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '拠点名:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: baseName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '住所:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: address,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '拠点の電話番号:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: telephoneNumber,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '拠点の管理者:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: manager,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '詳細情報:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextArea(
                                borderRadius: 0,
                                borderColor: Colors.grey,
                                textEditingController: detailedInformation,
                                onSuffixIconPressed: () => {},
                                validation: false,
                                errorText: 'Please type a reason!',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Image.network(basePhoto.text.replaceAll('"', ''),
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network('https://static.thenounproject.com/png/482114-200.png',
                                width: 30,height: 30,),
                                Text('拠点写真')
                              ],
                            ),
                          );
                        }),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '拠点写真:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: basePhoto,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: coordinate,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 0, bottom: 5, right: 0),
                                    child: Align(
                                      widthFactor: 1,
                                      heightFactor: 0,
                                      alignment: Alignment.centerLeft,
                                      child: Text("座標：",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: engravingRangeRadius,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 0, bottom: 5, right: 0),
                                    child: Align(
                                      widthFactor: 1,
                                      heightFactor: 0,
                                      alignment: Alignment.centerLeft,
                                      child: Text("打刻の範囲/半径：",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      final offices = Office.changeData(
                          baseName.text,
                          address.text,
                          telephoneNumber.text,
                          manager.text,
                          basePhoto.text,
                          detailedInformation.text,
                          coordinate.text,
                          engravingRangeRadius.text);
                      if (_formKey.currentState!.validate()) {
                        if (office.officeId == null) {
                          controller.createData(offices);
                          Navigator.of(context).pop();
                          Get.snackbar(
                            "Alert",
                            "Create Success",
                            backgroundColor: Colors.green,
                            icon: const Icon(Icons.add_alert),
                          );
                        } else {
                          controller.updateData(
                              offices, office.officeId.toString());
                          Navigator.of(context).pop();
                          Get.snackbar(
                            "Alert",
                            "Update Success",
                            backgroundColor: Colors.green,
                            icon: const Icon(Icons.add_alert),
                          );
                        }
                      }
                    },
                    child: Text('検索'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
