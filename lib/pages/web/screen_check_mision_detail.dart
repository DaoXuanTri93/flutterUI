import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/controller/screenCheckMissionController.dart';
import 'package:login_app/controller/teamApprovalController.dart';
import 'package:login_app/main.dart';
import 'package:login_app/model/TeamApprovalModel.dart';


class ScreenMissionDetail extends StatelessWidget {
  ScreenMissionDetail({super.key});

  final CheckMissionController checkMissionController =
  Get.put(CheckMissionController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                    () =>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Màn hình chi  tiết mission', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                        SizedBox(height: 10),
                        Text('USER-NAME:', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: checkMissionController.detailMissionApproval
                                .value.userName,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('START-DAY:', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: checkMissionController.detailMissionApproval
                                .value.startDay,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('END-DAY:', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: checkMissionController.detailMissionApproval
                                .value.endDay,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(onPressed: (){
                          Get.back();
                        }, child: Text("Cancel"))
                      ],
                    ),
              ),
            ),
          ),
        ));
  }
}