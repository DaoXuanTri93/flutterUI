import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:login_app/services/timekeepingservices.dart';
import '../button/button.dart';
import '../const/const.dart';
import '../controller/timeKeepingController.dart';

class TimekeepingPage extends StatelessWidget {
  TimekeepingPage({super.key});
  final TimekeepingController controller = Get.put(TimekeepingController());

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
                      onPressed: !controller.isCheckin.value ? () {
                        EasyLoading.show();
                        return controller.checkIn();
                      } : null,
                      colors: controller.isCheckin.value ? Colors.grey.withOpacity(0.8) : Colors.blue,
                      text: Text(buttonCheckin,
                          style: const TextStyle(fontSize: 20, color: Colors.white)),
                      radius: 8)),
            ),
            Obx(() => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ButtonScreen(

                    onPressed: !controller.isCheckout.value ? () {
                      EasyLoading.show();
                      return controller.checkOut();
                    } : null,
                    colors: controller.isCheckout.value ? Colors.grey.withOpacity(0.8) : Colors.blue,
                    text: Text(buttonCheckout,
                        style: const TextStyle(fontSize: 20, color: Colors.white)),
                    radius: 8,
                  ),
                )),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                child: ButtonScreen(
                    onPressed: () => Get.toNamed("missionpage") ,
                    text: Text(buttonBusinessTrip,
                        style: const TextStyle(fontSize: 20, color: Colors.white)),
                    radius: 8)),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: ButtonScreen(
                  onPressed: () {
                    return TimeKeepingServices().showInputStartOverTime(context);
                  },
                  text: Text(buttonStartOverTime,
                      style: const TextStyle(fontSize: 20, color: Colors.white)),
                  radius: 8),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: ButtonScreen(
                  onPressed: () {
                    return TimeKeepingServices().showInputEndOverTime(context);
                  },
                  text: Text(buttonEndOverTime,
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  radius: 8),
            )
          ],
        ),
      ),
    );
  }

}
