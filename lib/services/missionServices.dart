import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:intl/intl.dart';
import 'package:login_app/auth/authentical.dart';
import '../controller/missionController.dart';
import 'HomeProviders.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class MissionServices {
  Future registerMission(BuildContext context,Map data,controller) async {
    final token = globals.token;
    Response response = await HomeProviders().mission(token!, data);
    if (response.statusCode == 201) {
      Get.snackbar("Đăng kí công tác thành công", "");
      controller.getDataMission();
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Get.snackbar("Lỗi", response.body["message"]);
    }
  }

  Future editMission(BuildContext context, Map data, id,MissionController controller) async {
    final token = globals.token;
    Response response = await HomeProviders().editMission(token, data, id);
    if (response.statusCode == 200) {
      Get.snackbar("Đăng kí công tác thành công", "");
      controller.getDataMission();
      Navigator.pop(context);
    } else {
      Get.snackbar("Đăng kí thất bại", response.body["message"]);
    }
  }

  Future cancelMisson(BuildContext context, id,MissionController controller) async {
    final token = globals.token;
    Response response = await HomeProviders().cancelMission(token, id);
    if (response.statusCode == 200) {
      Get.snackbar("Thao tác thành công", "");
      controller.getDataMission();
      Navigator.pop(context);
    } else {
      Get.snackbar("Đăng kí thất bại", response.body["message"]);
    }
  }

  Future showFormRegisterMission(
      BuildContext context, MissionController controller,
      {String? start, String? end, int? id}) async {
    TextEditingController timeStart = TextEditingController();
    TextEditingController timeEnd = TextEditingController();
    start != null ? timeStart.text = start : null;
    end != null ? timeEnd.text = end : null;
    final formKey = GlobalKey<FormState>();
    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              content: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    right: -40,
                    top: -40,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Start Day",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: timeStart,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Field is required';
                                  }
                                  if (timeEnd.text!=''&& timeStart.text.compareTo(timeEnd.text)>0) {
                                    return 'Time start > Time end';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                    focusColor: Colors.red,
                                    hintText: 'yyyy/MM/dd',
                                    suffixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(0))),
                                onTap: () async {
                                  DateTime? datepicker = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025));
                                  if (datepicker != null) {
                                    timeStart.text = DateFormat('yyyy/MM/dd')
                                        .format(datepicker);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("End Day",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: timeEnd,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Field is required';
                                  }
                                  if (timeEnd.text.compareTo(DateFormat('yyyy/MM/dd').format(DateTime.now()))<=0) {
                                    return 'Time end <= Now';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                    focusColor: Colors.red,
                                    hintText: 'yyyy/MM/dd',
                                    suffixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(0))),
                                onTap: () async {
                                  DateTime? datepicker = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025));
                                  if (datepicker != null) {
                                    timeEnd.text = DateFormat('yyyy/MM/dd')
                                        .format(datepicker);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Register'),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> data = {
                                  "startDay": timeStart.text,
                                  "endDay": timeEnd.text
                                };
                                if (start != null) {
                                  editMission(context, data, id,controller);
                                } else {
                                  registerMission(context,data,controller);
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Future getDataMission() async {
    final token = globals.token;
    List<dynamic> data = [];
    Response response = await HomeProviders().getAllMissionByUser(token);
    if (response.statusCode == 200) {
      data = response.body;
    }
    return data;
  }
}
