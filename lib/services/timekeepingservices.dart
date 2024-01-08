import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    try{
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
        Get.snackbar('Timekeeping failed', res.body["message"] ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
        return false;
      }
      Get.snackbar('Timekeeping successful', res.body["timeStartDay"],duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
      return true;
    }catch (e){
      Get.snackbar("Office coordinates cannot be determined","Please check again !!!",duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future checkout() async {
    try {
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
        Get.snackbar('Timekeeping failed', res.body["message"] ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
        return false;
      }
      Get.snackbar('Timekeeping successful', res.body["timeEndDay"],duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
      return true;
    }catch (e){
      Get.snackbar("Office coordinates cannot be determined","Please check again !!!",duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
    } finally {
      EasyLoading.dismiss();
    }
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
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close, color: Colors.white),
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
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                            child: const Text('Register', style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                EasyLoading.show();
                                _formKey.currentState!.save();
                                checkInOverTime(context,{"overTimeStart":_timeStart.text});
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
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close, color: Colors.white),
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
                            child: const Text('Resgiter', style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                EasyLoading.show();
                                checkOutOverTime(context,{"overTimeEnd":_endStart.text});
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

  checkInOverTime(BuildContext context, Map data)async{
    try {
      final token = globals.token;
      Response res = await HomeProviders().saveTimeStartOT(token,data);
      if (res.statusCode != 201) {
        Get.snackbar('Timekeeping overtime fail', res.body["message"] ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
        return false;
      }
      Get.snackbar('Timekeeping overtime successful', res.body["overTimeStart"],duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
      return true;
    }catch(e) {
      throw Exception(e);
    }finally{
      EasyLoading.dismiss();
      Navigator.pop(context);
    }
  }

  checkOutOverTime(BuildContext context, Map data)async{
    try {
      final token = globals.token;
      Response res = await HomeProviders().saveTimeEndOT(token,data);
      if (res.statusCode != 201) {
        Get.snackbar('Timekeeping overtime fail', res.body["message"] ,duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.redAccent.withOpacity(0.3));
        return false;
      }
      Get.snackbar('Timekeeping overtime successful', res.body["overTimeEnd"],duration: Duration(milliseconds: 1500, ) , backgroundColor: Colors.green.withOpacity(0.3));
    }catch(e) {
      throw Exception(e);
    }finally{
      EasyLoading.dismiss();
      Navigator.pop(context);
    }
  }
}
