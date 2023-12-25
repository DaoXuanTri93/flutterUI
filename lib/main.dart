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
import 'package:login_app/pages/web/screen_check_team.dart';
import 'package:login_app/pages/upload_image_new.dart';
import 'package:login_app/pages/web/screen_check_team_detail.dart';
import 'package:url_strategy/url_strategy.dart';
import 'pages/web/dashboard/narbargation.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

import 'pages/web/loginpageweb.dart';
void main() async {
  await GetStorage.init();
  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("token123");
    print(globals.token);
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
          GetPage(name: '/screenCheckTeamDetail',page: () => ScreenCheckTeamDetail()),
          GetPage(name: '/loginPageWeb',page: () => LoginPageWeb()),

          GetPage(name: '/navigationBarDemo',page: () => NavigationBarDemo()),
        ],
        debugShowCheckedModeBanner: false);
  }
}
