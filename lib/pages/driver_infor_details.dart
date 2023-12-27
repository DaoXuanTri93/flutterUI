import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('運転手情報詳細',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '運転手名 :',
                  ),
                ),
                TextFormField(
                  controller: userName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('運転手ID :'),
                ),
                TextFormField(
                  controller: staffId,
                  readOnly: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('生年月日 :'),
                ),
                TextFormField(
                  controller: dateOfBirth,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('運転免許番号 :'),
                ),
                TextFormField(
                  controller: drivingLicenseNumber,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('エリア :'),
                ),
                TextFormField(
                  controller: area,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('出張有無 :'),
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
                     Map<String, dynamic> data = {
                       'userName':userName.text,"dateOfBirth":dateOfBirth.text,"area":area.text,"mission":"false","phone":drivingLicenseNumber.text
                     };
                     controller.updateDriver(data, id);
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.infinity, 40),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2))),
                    child: const Text('編集')),
              ],
            ),
          ),
        ));
      },
    );
  }
}
