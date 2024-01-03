import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../button/button.dart';
import '../const/const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut() {
      Get.toNamed('imageUpload');
      // AuthenticationManager().logOut();
    }

    return Scaffold(
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          child: ButtonScreen(
                onPressed: () => Get.toNamed("/timekeepingpage"),
                text: Text("Chấm công", style: const TextStyle(fontSize: 20)),
                radius: 8),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          child: ButtonScreen(
                onPressed: () => Get.toNamed("/schedulepage"),
                text: Text(buttonRegisterTimekeeping,
                    style: const TextStyle(fontSize: 20)),
                radius: 8),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          child: ButtonScreen(
                onPressed: () => Get.toNamed("/imageUpload"),
                text: Text(buttonEnterDistance,
                    style: const TextStyle(fontSize: 20)),
                radius: 8),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          child: ButtonScreen(
              onPressed: () => Get.toNamed("/stamping-approval-screen"),
              text: Text(buttonEnterStamping,
                  style: const TextStyle(fontSize: 20)),
              radius: 8),
        ),
      ],
    ),
            )));
  }
}
