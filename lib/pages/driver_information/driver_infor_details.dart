import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/font_text.dart';

class DriverInforDetails extends StatelessWidget {
  DriverInforDetails({super.key});

  var driverName = TextEditingController();
  var driverID = TextEditingController();
  var birthDate = TextEditingController();
  var licenseNumber = TextEditingController();
  var area = TextEditingController();
  // var businessTrip = TextEditingController();

  var businessTripChecked = false.obs;
  @override
  Widget build(BuildContext context) {
    if(Get.arguments != null){
      driverName.text = Get.arguments[1];
      driverID.text = Get.arguments[11];
      birthDate.text = Get.arguments[12];
      licenseNumber.text = Get.arguments[13];
      area.text = Get.arguments[3];
      // businessTrip.text = Get.arguments[8];
    }
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
                  child: Text('運転手情報詳細', style: TextFont.textFont.titleLarge,),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('運転手名 :',style: TextFont.textFont.titleMedium,),
                ),
                TextFormField(
                  controller: driverName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('運転手ID :',style: TextFont.textFont.titleMedium,),
                ),
                TextFormField(
                  controller: driverID,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('生年月日 :',style: TextFont.textFont.titleMedium,),
                ),
                TextFormField(
                  controller: birthDate,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('運転免許番号 :',style: TextFont.textFont.titleMedium,),
                ),
                TextFormField(
                  controller: licenseNumber,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('エリア :',style: TextFont.textFont.titleMedium,),
                ),
                TextFormField(
                  controller: area,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('出張有無 :',style: TextFont.textFont.titleMedium),
                ),
                Center(
                  child: Obx(
                        () => Checkbox(
                      value: businessTripChecked.value,
                      onChanged: (bool? value) {
                        businessTripChecked.value =! businessTripChecked.value;
                      },),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Get.toNamed('/stamp-approval-search');

                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.infinity, 40) ,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(2)
                      )
                  ),
                  child: const Text('編集'),
                )
              ],
            ),
          ),
        )
    );
  }
}
