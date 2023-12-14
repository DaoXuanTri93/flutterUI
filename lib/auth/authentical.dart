
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:login_app/pages/homepages.dart';
import 'package:login_app/pages/loginpage.dart';
import '../services/HomeProviders.dart';
import 'cacheManager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
    HomeProviders().logOut();
    Get.off(LoginPage());
  }

  void login(String username, String password, bool ischeckSave,String mac) async {
    Map<String, dynamic> user = {
      "username": username,
      "password": password,
      "MAC": mac,
      "isWeb":kIsWeb
    };
    Response response = await HomeProviders().login(user);
    Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
    if(response.statusCode!=200){
      Get.snackbar("Đăng nhập thất bại", data["message"]);
     throw Exception("Đăng nhập thất bại");
    }
    if(ischeckSave){
      await saveToken(data["jwt"]);
    }
    isLogged.value = true;
    Get.off(const HomePage());
  }

  Future<Map<String, dynamic>> checkLoginStatus() async{
    Map<String, dynamic> user = {};
    final token = getToken();
    print(token);
    if(token == null){
      return user;
    }
    Response response = await HomeProviders().getUser(token);
    print(response.body["username"]);
    return response.statusCode==200? response.body : user;
  }

  @override
  void onInit() {
    super.onInit();
  }
}