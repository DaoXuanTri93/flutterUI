import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:login_app/services/positionservices.dart';
import 'package:login_app/global-variable/globals.dart' as globals;
import 'homeProviders.dart';

class TimeKeepingServices {

  Future getDataTimeKeeping() async {
    final token = globals.token;
    Map<String, dynamic> data = {};
    Response response = await HomeProviders().getDataTimeKeeping(token!);
    if (response.statusCode == 200) {
      data = response.body;
    }
    return data;
  }

  Future checkin() async {
    final token = globals.token;
    final positionLocal = await PositionServices().getLocaltion();

    Response response = await HomeProviders().getCoordinate(token!);
    if (response.statusCode != 200) {
      throw Exception(response.body["message"]);
    }
    final positionOffice = response.body[0]["coordinate"].split(",");
    final latOffice = double.parse(positionOffice[0]);
    final longOffice = double.parse(positionOffice[1]);

    double distanceInMeters = Geolocator.distanceBetween(
        positionLocal.latitude, positionLocal.longitude, latOffice, longOffice);
    Map<String, dynamic> checkPosition = {};
    if (distanceInMeters > 200) {
      checkPosition = {"check" : false};
    }
    Response res = await HomeProviders().checkIn(token,checkPosition);
    if (res.statusCode != 201) {
      Get.snackbar("Chấm công thất bại", res.body["message"]);
      return false;
    }
    Get.snackbar("Chấm công thành công", res.body["timeStartDay"]);
    return true;
  }

  Future checkout() async {
    final token = globals.token;
    final positionLocal = await PositionServices().getLocaltion();

    Response response = await HomeProviders().getCoordinate(token!);
    if (response.statusCode != 200) {
      throw Exception(response.body["message"]);
    }
    final positionOffice = response.body[0]["coordinate"].split(",");
    final latOffice = double.parse(positionOffice[0]);
    final longOffice = double.parse(positionOffice[1]);

    double distanceInMeters = Geolocator.distanceBetween(
        positionLocal.latitude, positionLocal.longitude, latOffice, longOffice);
    Map<String, dynamic> checkPosition = {};
    if (distanceInMeters > 200) {
      checkPosition = {"check" : false};
    }
    Response res = await HomeProviders().checkOut(token,checkPosition);
    if (res.statusCode != 201) {
      Get.snackbar("Chấm công thất bại", res.body["message"]);
      return false;
    }
    Get.snackbar("Chấm công thành công", res.body["timeEndDay"]);
    return true;
  }

  Future showInputStartOverTime(BuildContext context) async {
    TextEditingController _timeStart = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: _timeStart,
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                                hintText: '--:-- --',
                                suffixIcon: const Icon(Icons.access_time),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onTap: () async {
                              TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.dial);
                              if (timeOfDay != null) {
                                _timeStart.text = timeOfDay.format(context);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Đăng kí'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                checkInOverTime({"overTimeStart":_timeStart.text});
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

  Future showInputEndOverTime(BuildContext context) async {
    TextEditingController _endStart = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: _endStart,
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                                hintText: '--:-- --',
                                suffixIcon: const Icon(Icons.access_time),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onTap: () async {
                              TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.dial);
                              if (timeOfDay != null) {
                                _endStart.text = timeOfDay.format(context);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Đăng kí'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                checkOutOverTime({"overTimeEnd":_endStart.text});
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

  checkInOverTime(Map data)async{
    final token = globals.token;
    Response res = await HomeProviders().saveTimeStartOT(token,data);
    if (res.statusCode != 201) {
      Get.snackbar("Chấm công ngoài giờ thất bại", res.body["message"]);
      return false;
    }
    Get.snackbar("Chấm công ngoài giờ thành công", res.body["overTimeStart"]);
    return true;
  }

  checkOutOverTime(Map data)async{
    final token = globals.token;
    Response res = await HomeProviders().saveTimeEndOT(token,data);
    if (res.statusCode != 201) {
      Get.snackbar("Chấm công ngoài giờ thất bại", res.body["message"]);
      return false;
    }
    Get.snackbar("Chấm công ngoài giờ thành công", res.body["overTimeEnd"]);

  }
}
