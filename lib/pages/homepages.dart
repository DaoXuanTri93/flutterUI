import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_app/auth/authentical.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut(){
      Get.toNamed('imageUpload');
      // AuthenticationManager().logOut();
    }
    return  Scaffold(body: Center(child: ElevatedButton(
        onPressed: logOut,
        child: Text("Logout"))));
  }
}
