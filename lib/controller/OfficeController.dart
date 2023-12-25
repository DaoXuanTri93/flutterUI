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
    }
  }

  void searchListOffice(Office office) async {
    List<Office> filteredList = officeList
        .where((e) =>
            (office.baseName == ''
                ? true
                :e.baseName == null ? false : e.baseName!.contains(office.baseName!)) &&
            (office.address == ''
                ? true
                : e.address == null ? false : e.address!.contains(office.address!)) &&
            (office.telephoneNumber == ''
                ? true
                : e.telephoneNumber == null ? false : e.telephoneNumber!.contains(office.telephoneNumber!)) &&
            (office.manager == ''
                ? true
                : e.manager == null ? false : e.manager!.contains(office.manager!)) &&
            (office.driverInformation == ''
                ? true
                : e.driverInformation == null ? false : e.driverInformation!.contains(office.driverInformation!)) &&
            (office.drivingRoute == ''
                ? true
                : e.drivingRoute == null ? false : e.drivingRoute!.contains(office.drivingRoute!)) &&
            (office.vehicleInformation == ''
                ? true
                : e.vehicleInformation == null ? false : e.vehicleInformation!.contains(office.vehicleInformation!)) &&
            (office.drivingSchedule == ''
                ? true
                : e.drivingSchedule == null ? false : e.drivingSchedule!.contains(office.drivingSchedule!)))
        .toList();

    searchOfficeList.value = filteredList;
  }
  void createData(Office office) async {
      print(office.officeId);
      final body = {
        "baseName" : office.baseName,
        "basePhoto" : office.basePhoto,
        "address" : office.address,
        "telephoneNumber" : office.telephoneNumber,
        "manager" : office.manager,
        "detailedInformation" : office.detailedInformation,
        "coordinate" : office.coordinate,
        "engravingRangeRadius" : office.engravingRangeRadius,
      };
      final url = 'http://localhost:3000/office/';
      final response = await _getConnect.post(url, body);
      getOffice();
  }
  void updateData(Office office, String id) async {
    final body = {
      "baseName" : office.baseName,
      "basePhoto" : office.basePhoto,
      "address" : office.address,
      "telephoneNumber" : office.telephoneNumber,
      "manager" : office.manager,
      "detailedInformation" : office.detailedInformation,
      "coordinate" : office.coordinate,
      "engravingRangeRadius" : office.engravingRangeRadius,
    };
    final url = 'http://localhost:3000/office/${id}';
    final response = await _getConnect.put(url, body);
    getOffice();
  }
}
