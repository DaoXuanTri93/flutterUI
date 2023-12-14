import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../button/button.dart';
import '../const/const.dart';
import '../controller/homeController.dart';

class TimekeepingPage extends StatelessWidget {
  TimekeepingPage({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              stampingScreen,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ButtonScreen(
                      onPressed: !controller.isCheckin.value ? () {} : null,
                      text: Text(buttonCheckin,
                          style: const TextStyle(fontSize: 20)),
                      radius: 8)),
            ),
            Obx(() => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ButtonScreen(
                    onPressed: !controller.isCheckin.value ? () {} : null,
                    text: Text(buttonCheckout,
                        style: const TextStyle(fontSize: 20)),
                    radius: 8,
                  ),
                )),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                child: ButtonScreen(
                    onPressed: () {},
                    text: Text(buttonBusinessTrip,
                        style: const TextStyle(fontSize: 20)),
                    radius: 8)),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: ButtonScreen(
                  onPressed: () {},
                  text: Text(buttonStartOverTime,
                      style: const TextStyle(fontSize: 20)),
                  radius: 8),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: ButtonScreen(
                  onPressed: () {},
                  text: Text(buttonEndOverTime,
                      style: const TextStyle(fontSize: 20)),
                  radius: 8),
            ),
          ],
        ),
      ),
    );
  }
}
