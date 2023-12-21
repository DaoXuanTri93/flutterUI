import 'package:get/get.dart';




class ImageConnect extends GetConnect {
  Future<Response> createEnterDistance(Map data, String token) async =>
      await post('http://192.168.24.11:3000/driver/createEnterDistance', data, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });
  Future<Response> updateEnterDistance(Map data, String token) async =>
      await post('http://192.168.24.11:3000/driver/updateEnterDistance', data, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });

  Future<Response> findOneDriver(String token) async =>
      await get('http://192.168.24.11:3000/driver/findOneEnterDistance', headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });
}
