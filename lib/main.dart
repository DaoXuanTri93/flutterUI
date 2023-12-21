
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/controller/teamApprovalController.dart';
import 'package:login_app/pages/loadingpage.dart';
import 'package:login_app/pages/screen_check_team.dart';
import 'package:login_app/pages/upload_image_new.dart';
import 'package:url_strategy/url_strategy.dart';
import 'auth/authentical.dart';
import 'controller/homeController.dart';
import 'pages/screen_check_team_detail.dart';



void main ()async{

  await GetStorage.init();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return GetMaterialApp(
        initialRoute: '/',
        getPages: [
            GetPage(name: '/imageUpload', page: () =>  UploadImageNew()),
             GetPage(name: '/screenCheckTeam', page: () =>  ScreenCheckTeam()),
          GetPage(name: '/screenCheckTeamDetail', page: () =>  ScreenCheckTeamDetail()),
        ],
        home: SafeArea(
            child: ScreenCheckTeam()
        ),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false
    );
  }
}