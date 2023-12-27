import 'dart:convert';

import 'package:get/get.dart';
import 'package:login_app/model/TeamApprovalModel.dart';
import '../global-variable/globals.dart';
import '../services/driverServices.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class DriverController extends GetxController {
  DriverService driverService = DriverService();
  var isLoading = false.obs;
  var driverList = [].obs;
  var diverListSearch = [].obs;
  var officeName = ''.obs;
  final driver = {'userName':"",'staffId':"","dateOfBirth":'',"area":'',"mission":"false","phone":''}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    // Future.delayed(const Duration(seconds: 2), () async {   });
  }

  void fetchData() async {
    try {
      final token = globals.token;
      isLoading(true);
      Response response = await driverService.findAll(token);
      if (response.statusCode == 200) {
        driverList.value = diverListSearch.value = response.body;
        print(response.body);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  void dataSearch(Map<String, dynamic> dataSearch) {
    print("davoday${dataSearch['not-stamped']}");
    driverList.value = diverListSearch
        .where((p0) =>
            (dataSearch['affiliatedOffice'] == ''
                ? true
                : p0['officeName'].contains(dataSearch['affiliatedOffice'])) &&
            (dataSearch['userName'] == ''
                ? true
                : p0['userName'].contains(dataSearch['userName'])) &&
            (dataSearch['date'] == ''
                ? true
                : p0["dayTimeKeeping"] == null
                    ? false
                    : p0["dayTimeKeeping"]
                        .contains(dataSearch["date"].substring(0,10))) &&
            (dataSearch['area'] == ''
                ? true
                : p0["area"] == null
                    ? false
                    : p0["area"].contains(dataSearch["area"])) &&
            ((dataSearch['not-stamped'] == false &&
                    (p0['timeStartDay'] == null && p0['timeEndDay'] == null))
                ? true
                : (dataSearch['not-stamped'] == true &&
                    (p0['timeStartDay'] != null ||
                        p0['timeEndDay'] != null))) &&
            dataSearch['businessTrip'] == p0['workOutside'])
        .toList();

    print(driverList);

  }

  void getDataById(String id) async{
    final token = globals.token;
    Response response = await driverService.getdataById(id,token);
    print(response.statusCode);
    if(response.statusCode == 200){
      driver.value = Map<String,String>.from(response.body);
    }
  }

  void updateDriver(Map<String, dynamic> data,String id) async {
    final token = globals.token;
    print("data" + data['userName']);
    Response response = await driverService.updateDriver(id,token,data);
    if(response.statusCode == 200){
      print(response.body);
    }
  }
}
