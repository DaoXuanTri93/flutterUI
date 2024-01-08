import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
          child: Icon(Icons.account_balance, color: Colors.blue, size: 100)),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      getInstance().whenComplete(() {
        if (user.isNotEmpty) {
          if (kIsWeb) {
            Get.toNamed("/navigationBarDemo");
          } else {
            Get.toNamed("/homepage");
          }
        } else if (kIsWeb) {
          Get.toNamed("/loginPageWeb");
        } else {
          Get.toNamed("/loginpage");
        }
      });
      // user.isNotEmpty ? (kIsWeb ? Get.toNamed("/loginPageWeb") : Get.toNamed("/homepage")) : Get.toNamed("/loginPageWeb"));
    });
  }

  Future getInstance() async {
    user = await AuthenticationManager().checkLoginStatus();
  }
}
