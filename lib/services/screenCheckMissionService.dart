



import 'package:get/get.dart';
import 'package:login_app/const/const.dart';
import 'package:login_app/global-variable/globals.dart';

class CheckMissionService extends GetConnect{


  Future<Response> fetchData() async =>  await get('$SEVERNAME/mission/findAll',headers: {
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token' //carrier
  });
  Future<Response> statusMissionService(String id, Map approval) async =>  await post('$SEVERNAME/mission/approval/$id',approval,headers: {
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token' //carrier
  });

}