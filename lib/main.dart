import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/pages/driver_infor_details.dart';
import 'package:login_app/pages/forgotpage.dart';
import 'package:login_app/pages/homepages.dart';
import 'package:login_app/pages/loadingpage.dart';
import 'package:login_app/pages/loginpage.dart';
import 'package:login_app/pages/missionpage.dart';
import 'package:login_app/pages/schedulepage.dart';
import 'package:login_app/pages/timekeepingpage.dart';
import 'package:login_app/pages/web/driver_infor.dart';
import 'package:login_app/pages/web/screen_check_team.dart';
import 'package:login_app/pages/upload_image_new.dart';
import 'package:login_app/pages/web/screen_check_team_detail.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:login_app/global-variable/globals.dart' as globals;
import 'package:login_app/auth/cookie_manager.dart' as cookie;
void main() async {
  await GetStorage.init();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    globals.token = cookie.getToken("jwt") ?? "";
    return GetMaterialApp(
        initialRoute: '/loadingpage',
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
          GetPage(
              name: '/driver-infor-detail',
              page: () => DriverInforDetails()),
          GetPage(
              name: '/driver-infor',
              page: () => DriverInforSearch())
        ],
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false);
  }
}
