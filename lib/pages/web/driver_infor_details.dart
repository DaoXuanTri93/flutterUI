import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/const/fontText.dart';
import 'package:login_app/controller/driverController.dart';


class DriverInforDetails extends StatelessWidget {
  DriverInforDetails({super.key});


  final TextEditingController userName = TextEditingController();
  final TextEditingController staffId = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController drivingLicenseNumber = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController businessTrip = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DriverController controller = Get.put(DriverController());
    final businessTripChecked = false.obs;
    final id = Uri.base.path.split('/')[2];
    print(id);
    controller.getDataById(id);
    print(controller.driver);
    // userName.text = controller.driver['userName'];
    // staffId.text = controller.driver['staffId'];
    // dateOfBirth.text = controller.driver['dateOfBirth'];
    // drivingLicenseNumber.text = controller.driver['phone'];
    // area.text = controller.driver['area'];
    // businessTrip.text = controller.driver['mission'];
    return Obx(
          () {
        print(controller.driver);
        userName.text = controller.driver['userName']!;
        staffId.text = controller.driver['staffId']!;
        dateOfBirth.text = controller.driver['dateOfBirth']!;
        drivingLicenseNumber.text = controller.driver['phone']!;
        area.text = controller.driver['area']!;
        businessTripChecked.value = bool.parse(controller.driver['mission']!);
        return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        '運転手情報詳細',
                        style: textFont.titleLarge,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          '運転手名 :',
                          style: textFont.titleMedium
                      ),
                    ),
                    TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          '運転手ID :',
                          style: textFont.titleMedium),
                    ),
                    TextFormField(
                      controller: staffId,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          '生年月日 :',
                          style: textFont.titleMedium),
                    ),
                    TextFormField(
                      controller: dateOfBirth,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          '運転免許番号 :',
                          style: textFont.titleMedium),
                    ),
                    TextFormField(
                      controller: drivingLicenseNumber,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('エリア :',
                          style: textFont.titleMedium),
                    ),
                    TextFormField(
                      controller: area,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          '出張有無 :',
                          style: textFont.titleMedium),
                    ),
                    Center(
                      child: Obx(
                            () => Checkbox(
                          value: businessTripChecked.value,
                          onChanged: (bool? value) {
                            businessTripChecked.value = !businessTripChecked.value;
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Map<String, dynamic> data = {
                            'userName':userName.text,"dateOfBirth":dateOfBirth.text,"area":area.text,"mission":"false","phone":drivingLicenseNumber.text
                          };
                          controller.updateDriver(data, id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                            fixedSize: const Size(double.infinity, 40),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(2))),
                        child: const Text('編集',style: TextStyle(color: Colors.white),)),
                  ],
                ),
              ),
            ));
      },
    );
  }
}