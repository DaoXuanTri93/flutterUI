
import 'package:get/get.dart';

import '../const/const.dart';

class TeamApprovalService extends GetConnect{
  // Future<Response> findAll() async =>
  //     await get('$SEVERNAME/stampApprovalController/findAll');

  Future<Response> updateTeamApproval(String id ,Map<String, dynamic> data, String token ) async =>
      await post('$SEVERNAME/stampApprovalController/$id',data, headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });

  Future<Response> findAllOfLuyn(String token) async =>
      await get('$SEVERNAME/stampApprovalController',headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });

  Future<Response> approval(String token, String id) async =>
      await get('$SEVERNAME/stampApprovalController/$id',headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token' //carrier
      });

  Future<Response> findAll(String token) async =>
      await get('$SEVERNAME/stampApprovalContrller/findAll',headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
}