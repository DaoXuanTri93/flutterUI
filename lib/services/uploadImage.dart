import 'package:get/get.dart';

import '../const/const.dart';




class ImageConnect extends GetConnect {
  Future<Response> createEnterDistance(Map data, String token) async =>
      await post('$SEVERNAME/driver/createEnterDistance', data, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });
  Future<Response> updateEnterDistance(Map data, String token) async =>
      await post('$SEVERNAME/driver/updateEnterDistance', data, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });

  Future<Response> findOneDriver(String token) async =>
      await get('$SEVERNAME/driver/findOneEnterDistance', headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });
}
