import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_app/pages/homepages.dart';
import 'package:login_app/pages/loginpage.dart';

import '../auth/authentical.dart';

Map<String, dynamic> user = {};

class LoadingPages extends StatefulWidget {
  const LoadingPages({super.key});

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

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      getInstance().whenComplete(() =>
          user.isNotEmpty ? Get.toNamed("/homepage") : Get.toNamed("/loginPageWeb"));
    });
  }

  Future getInstance() async {
    user = await AuthenticationManager().checkLoginStatus();
  }
}
