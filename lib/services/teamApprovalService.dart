



import 'package:get/get.dart';

class TeamApprovalService extends GetConnect{
  Future<Response> findAll() async =>
      await get('http://localhost:3000/stampApprovalContrller/findAll');

  Future<Response> updateTeamApproval(String id) async =>
      await get('http://localhost:3000/stampApprovalContrller/update/$id');
}