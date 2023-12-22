import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/pages/forgotpage.dart';
import 'package:login_app/pages/homepages.dart';
import 'package:login_app/pages/loadingpage.dart';
import 'package:login_app/pages/loginpage.dart';
import 'package:login_app/pages/missionpage.dart';
import 'package:login_app/pages/schedulepage.dart';
import 'package:login_app/pages/timekeepingpage.dart';
// import 'package:untitled2/pages/detailoffice.dart';
// import 'package:untitled2/pages/detailuser.dart';
// import 'package:untitled2/pages/distancepage.dart';
// import 'package:untitled2/pages/driver_info.dart';
// import 'package:untitled2/pages/driver_info_detail.dart';
// import 'package:untitled2/pages/findoffice.dart';
// import 'package:untitled2/pages/forgot.dart';
// import 'package:untitled2/pages/home.dart';
// import 'package:untitled2/pages/mappage.dart';
// import 'package:untitled2/pages/permissionssettings.dart';
// import 'package:untitled2/pages/scheduleservices.dart';
// import 'package:untitled2/pages/screen_check_team.dart';
// import 'package:untitled2/pages/screen_check_team_detail.dart';
// import 'package:untitled2/pages/timekeeppage.dart';
// import 'package:untitled2/pages/login.dart';
import 'package:login_app/controller/teamApprovalController.dart';
import 'package:login_app/pages/loadingpage.dart';
import 'package:login_app/pages/web/screen_check_team.dart';
import 'package:login_app/pages/upload_image_new.dart';
import 'package:login_app/pages/web/screen_check_team_detail.dart';
import 'package:url_strategy/url_strategy.dart';
import 'auth/authentical.dart';
void main() async {
  await GetStorage.init();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/homepage', page: () => HomePage()),
          GetPage(name: '/loginpage', page: () => LoginPage()),
          GetPage(name: '/loadingpage', page: () => LoadingPages()),
          GetPage(name: '/forgotpage', page: () => ForgotPage()),
          GetPage(name: '/timekeepingpage', page: () => TimekeepingPage()),
          GetPage(name: '/schedulepage', page: () => SchedulePage()),
          GetPage(name: '/missionpage', page: () => MissionPage()),
          GetPage(name: '/imageUpload', page: () => UploadImageNew()),
          GetPage(name: '/screenCheckTeam', page: () => ScreenCheckTeam()),
          GetPage(
              name: '/screenCheckTeamDetail',
              page: () => ScreenCheckTeamDetail()),
        ],
        home: const SafeArea(child: LoadingPages()),
        debugShowCheckedModeBanner: false);
  }
}
