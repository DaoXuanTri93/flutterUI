import 'dart:convert';

import 'package:get/get.dart';
import 'package:login_app/modals/office.dart';

class OfficeController extends GetxController {
  final _getConnect = GetConnect();
  var officeList = <Office>[];
  var searchOfficeList = <Office>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOffice();
  }

  getOffice() async {
    const String url = 'http://localhost:3000/office';
    final response = await _getConnect.get(url);
    if (response.statusCode == 200) {
      final List result = response.body;
      final data = result.map((e) => Office.fromJson(e)).toList();
      searchOfficeList.value = data;
      officeList = data;
    } else {
      print("ihihihihi");
    }
  }

  void searchListOffice(Office office) async {
    print(office.baseName);
    List<Office> filteredList = officeList
        .where((e) =>
            (office.baseName == ''
                ? true
                : e.baseName!.contains(office.baseName!)) &&
            (office.address == ''
                ? true
                : e.address!.contains(office.address!)) &&
            (office.telephoneNumber == ''
                ? true
                : e.telephoneNumber!.contains(office.telephoneNumber!)) &&
            (office.manager == ''
                ? true
                : e.manager!.contains(office.manager!)) &&
            (office.driverInformation == ''
                ? true
                : e.driverInformation!.contains(office.driverInformation!)) &&
            (office.drivingRoute == ''
                ? true
                : e.drivingRoute!.contains(office.drivingRoute!)) &&
            (office.vehicleInformation == ''
                ? true
                : e.vehicleInformation!.contains(office.vehicleInformation!)) &&
            (office.drivingSchedule == ''
                ? true
                : e.drivingSchedule!.contains(office.drivingSchedule!)))
        .toList();

    searchOfficeList.value = filteredList;
  }
}
