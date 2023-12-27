import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:login_app/pages/loginpage.dart';
import '../services/HomeProviders.dart';
import 'cacheManager.dart';
import 'package:login_app/global-variable/globals.dart' as globals;
import 'package:login_app/auth/cookie_manager.dart' as cookie;

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  static String token = '';
  void logOut() {
    isLogged.value = false;
    removeToken();
    HomeProviders().logOut();
    globals.token = "";
    Get.off(LoginPage());
  }

  void login(
      String username, String password, bool ischeckSave, String mac) async {
    Map<String, dynamic> user = {
      "username": username,
      "password": password,
      "MAC": mac,
      "isWeb": kIsWeb
    };
    Response response = await HomeProviders().login(user);
    Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
    if (response.statusCode != 200) {
      Get.snackbar("Đăng nhập thất bại", data["message"]);
      throw Exception("Đăng nhập thất bại");
    }
    if (ischeckSave) {
      await saveToken(data["jwt"]);
    }
    token = data["jwt"];
    cookie.setToken('jwt', token);
    globals.token = token;
    isLogged.value = true;
    kIsWeb ? Get.offNamed("/driver-infor") : Get.offNamed("/homepage");
  }

  Future<Map<String, dynamic>> checkLoginStatus() async {
    Map<String, dynamic> user = {};
    final storagetoken = getToken();
    if (storagetoken == null) {
      globals.token = "";
      return user;
    }
    token = storagetoken;
    globals.token = storagetoken;
    Response response = await HomeProviders().getUser(token);
    return response.statusCode == 200 ? response.body : user;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
