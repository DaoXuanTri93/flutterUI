import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:intl/intl.dart';
import '../controller/missionController.dart';
import 'homeProviders.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class MissionServices {
  Future registerMission(BuildContext context,Map data,controller) async {
    try {
      final token = globals.token;
      Response response = await HomeProviders().mission(token!, data);
      if (response.statusCode == 201) {
        Get.snackbar('Notification', 'Register mission successfully',duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
        controller.getDataMission();
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        Get.snackbar('Register fail', response.body["message"] ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
      }
    }catch (e){
      throw Exception(e);
    }finally {
      EasyLoading.dismiss();
    }
  }

  Future editMission(BuildContext context, Map data, id,MissionController controller) async {
    try {
      final token = globals.token;
      Response response = await HomeProviders().editMission(token, data, id);
      if (response.statusCode == 200) {
        Get.snackbar('Notification', 'Update mission successfully',duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
        controller.getDataMission();
        Navigator.pop(context);
      } else {
        Get.snackbar('Update mission', response.body["message"] ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
      }
    }catch (e){
      throw Exception(e);
    }finally {
      EasyLoading.dismiss();
    }
  }

  Future cancelMisson(BuildContext context, id,MissionController controller) async {
   try {
     final token = globals.token;
     Response response = await HomeProviders().cancelMission(token, id);
     if (response.statusCode == 200) {
       Get.snackbar('Notification', 'Deleted successfully',duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
       controller.getDataMission();
     } else {
       Get.snackbar('Notification', 'Deleted failed' ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
     }
   }catch (e){
     throw Exception(e);
   }finally {
     EasyLoading.dismiss();
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
                      child:  CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.close, color: Colors.white),
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
                                    return 'Start day > End day';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                    focusColor: Colors.red,
                                    hintText: 'yyyy/mm/dd',
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
                                  if (timeEnd.text.compareTo(DateFormat('yyyy/MM/dd').format(DateTime.now()))<0) {
                                    return 'start day < End day';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.none,
                                decoration: InputDecoration(
                                    focusColor: Colors.red,
                                    hintText: 'yyyy/mm/dd',
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
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                            child: const Text('Register', style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> data = {
                                  "startDay": timeStart.text,
                                  "endDay": timeEnd.text
                                };
                                if (start != null) {
                                  EasyLoading.show();
                                  editMission(context, data, id,controller);
                                } else {
                                  EasyLoading.show();
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
