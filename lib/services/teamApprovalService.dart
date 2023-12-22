
import 'package:get/get.dart';

import '../const/const.dart';

class TeamApprovalService extends GetConnect{
  Future<Response> findAll() async =>
      await get('$SEVERNAME/stampApprovalContrller/findAll');

  Future<Response> updateTeamApproval(String id) async =>
      await get('$SEVERNAME/stampApprovalContrller/update/$id');
}