import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/auth/authentical.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut(){
      AuthenticationManager().logOut();
    }
    return  Scaffold(body: Center(child: ElevatedButton(
        onPressed: ()=>Get.toNamed("/timekeepingpage"),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5))),
        child: Text("Chấm công"))));
  }
}
