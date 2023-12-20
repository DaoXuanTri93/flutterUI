import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/model/usermodel.dart';

class SearchUserController extends GetxController {

  var searchUserList = <SearchUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllSearchUser();
  }

  getAllSearchUser() async {

    const String staffUserUrl = 'http://localhost:3000/users/search';
    final response = await http.get(Uri.parse(staffUserUrl));

    if(response.statusCode==200){

      final List result = jsonDecode(response.body);

      searchUserList.value = result.map((e) => SearchUser.fromJson(e)).toList();

    }else{
      Get.snackbar('Error Loading Data !!! ',
          'Sever Responded : ${response.statusCode} : ${response.reasonPhrase.toString()}'
      );
    }
  }
}