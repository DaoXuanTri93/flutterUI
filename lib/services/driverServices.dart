
import 'package:get/get.dart';

import '../const/const.dart';

class DriverService extends GetConnect{

  Future<Response> findAll(String token) async =>
      await get('$SEVERNAME/timekeeping/driver',headers: {
      'Authorization': 'Bearer $token'
      });

  Future<Response> updateDriver(String id,String token,Map data) async =>
      await put('$SEVERNAME/timekeeping/driver/$id',data,headers:{
      'Authorization': 'Bearer $token'
      });

  Future<Response> getdataById(String id,String token) async =>
      await get('$SEVERNAME/timekeeping/driver/$id',headers: {
        'Authorization': 'Bearer $token'
      });
}