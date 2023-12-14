import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:login_app/auth/authentical.dart';
import 'package:login_app/services/positionservices.dart';

import 'officeProviders.dart';

class TimeKeepingServices {
  Future getDataTimeKeeping() async {
    Map<String, dynamic> data = {};
    final token = AuthenticationManager().getToken();
    Response response = await HomeProviders().getDataTimeKeeping(token!);
    if (response.statusCode == 200) {
      data = response.body;
    }
    return data;
  }

  Future checkin() async {
    final data = await PositionServices().getLocaltion();
    double distanceInMeters = Geolocator.distanceBetween(
        data.latitude, data.longitude, 52.3546274, 4.8285838);

  }
}
