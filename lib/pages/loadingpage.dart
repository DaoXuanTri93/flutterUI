import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_app/pages/homepages.dart';
import 'package:login_app/pages/loginpage.dart';

import '../auth/authentical.dart';
import '../controller/loadingcontroller.dart';

Map<String, dynamic> user = {};

class LoadingPages extends StatefulWidget {
   LoadingPages({super.key});
  final LoadingController controller = Get.put(LoadingController());
  @override
  State<LoadingPages> createState() => _LoadingPagesState();
}

class _LoadingPagesState extends State<LoadingPages> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Icon(
        Icons.access_time_outlined,
        size: 100,
      )),
    );
  }

  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 2), () async {
  //     getInstance().whenComplete(() =>
  //         // Get.toNamed("/loginpage"));
  //         user.isNotEmpty ? Get.toNamed("/homepage") : Get.toNamed("/loginpage"));
  //   });
  // }
  //
  // Future getInstance() async {
  //   user = await AuthenticationManager().checkLoginStatus();
  // }
}
