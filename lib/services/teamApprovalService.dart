
import 'package:get/get.dart';

import '../const/const.dart';

class TeamApprovalService extends GetConnect{
  Future<Response> findAll(String token) async =>
      await get('$SEVERNAME/stampApprovalContrller/findAll',headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });

  Future<Response> updateTeamApproval(String id, String token) async =>
      await get('$SEVERNAME/stampApprovalContrller/update/$id',headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
      });
}