import 'package:get/get.dart';
import 'package:login_app/models/staff_models.dart';

class StaffController extends GetxController{
  final _getConnect = GetConnect();
  var staffList = <Staff>[];
  var searchStaffList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getStaff();
  }

  getStaff() async {
    const String url = "http://localhost:3000/staff";
    final response = await _getConnect.get(url);
    if(response.statusCode == 200) {
      final result = response.body;
    print(result);
      final data = result.map((e) => Staff.fromJson(e)).toList();
      searchStaffList.value = data;
      print(searchStaffList.value[0].userName);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  // void searchListStaff(Staff staff) async {
  //   List<Staff> filteredList = staffList
  //       .where((e) =>
  //       (staff.affiliatedOffice == ''
  //           ? true
  //           : e.affiliatedOffice!.contains(staff.affiliatedOffice!)) &&
  //       (staff.userName == ''
  //           ? true
  //           : e.userName!.contains(staff.userName!)) &&
  //       (staff.date == ''
  //           ? true
  //           : e.date!.contains(staff.date!)) &&
  //       (staff.area == ''
  //           ? true
  //           : e.area!.contains(staff.area!)) &&
  //       (staff.clockInTime == ''
  //           ? true
  //           : e.clockInTime!.contains(staff.clockInTime!)) &&
  //       (staff.clockOutTime == ''
  //           ? true
  //           : e.clockOutTime!.contains(staff.clockOutTime!)) &&
  //       (staff.overtimeClockInTime == ''
  //           ? true
  //           : e.overtimeClockInTime!.contains(staff.overtimeClockInTime!)) &&
  //       (staff.overtimeClockOutTime == ''
  //           ? true
  //           : e.overtimeClockOutTime!.contains(staff.overtimeClockOutTime!)) &&
  //       (staff.businessTrip == ''
  //           ? true
  //           : e.businessTrip!.contains(staff.businessTrip!)) &&
  //       (staff.distance == ''
  //           ? true
  //           : e.distance!.contains(staff.distance!)) &&
  //       (staff.meterLink == ''
  //           ? true
  //           : e.meterLink!.contains(staff.meterLink!))
  //   ).toList();
  //
  //   searchStaffList.value = filteredList;
  // }
}