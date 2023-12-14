import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:login_app/auth/authentical.dart';
import 'package:login_app/services/positionservices.dart';

import 'HomeProviders.dart';

class TimeKeepingServices {
  final token = AuthenticationManager().getToken();
  Future getDataTimeKeeping() async {
    Map<String, dynamic> data = {};
    Response response = await HomeProviders().getDataTimeKeeping(token!);
    if (response.statusCode == 200) {
      data = response.body;
    }
    return data;
  }

  Future checkin() async {
    Map<String, dynamic> data = {};
    final positionLocal = await PositionServices().getLocaltion();

    Response response = await HomeProviders().getCoordinate(token!);
    if (response.statusCode != 200) {
      throw Exception(response.body["message"]);
    }
    data = response.body;
    final positionOffice = data["coordinate"].split(",");
    final latOffice = double.parse(positionOffice[0]);
    final longOffice = double.parse(positionOffice[1]);

    double distanceInMeters = Geolocator.distanceBetween(
        positionLocal.latitude, positionLocal.longitude, latOffice, longOffice);
    print(distanceInMeters);
    if(distanceInMeters > 200){
      Get.snackbar("Chấm công thất bại", "Bạn đang nằm ngoài phạm vi chấm công");
      return false;
    }
    Response res = await HomeProviders().checkIn(token!);
    if (res.statusCode != 201) {
      Get.snackbar("Chấm công thất bại",response.body["message"]);
      return false;
    }
    Get.snackbar("Chấm công thành công",res.body["timeStartDay"]);
    return true;
  }

  Future checkout() async {
    Map<String, dynamic> data = {};
    final positionLocal = await PositionServices().getLocaltion();

    Response response = await HomeProviders().getCoordinate(token!);
    if (response.statusCode != 200) {
      throw Exception(response.body["message"]);
    }
    data = response.body;
    final positionOffice = data["coordinate"].split(",");
    final latOffice = double.parse(positionOffice[0]);
    final longOffice = double.parse(positionOffice[1]);

    double distanceInMeters = Geolocator.distanceBetween(
        positionLocal.latitude, positionLocal.longitude, latOffice, longOffice);

    if(distanceInMeters > 200){
      Get.snackbar("Chấm công thất bại", "Bạn đang nằm ngoài phạm vi chấm công");
      return false;
    }
    Response res = await HomeProviders().checkOut(token!);
    if (res.statusCode != 201) {
      Get.snackbar("Chấm công thất bại",response.body["message"]);
      return false;
    }
    Get.snackbar("Chấm công thành công",res.body["timeEndDay"]);
    return true;
  }
}
