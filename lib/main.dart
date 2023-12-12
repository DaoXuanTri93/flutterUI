import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/pages/loadingpage.dart';
import 'package:login_app/pages/loginpage.dart';
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
// import 'package:untitled2/pages/schedulepage.dart';
// import 'package:untitled2/pages/screen_check_team.dart';
// import 'package:untitled2/pages/screen_check_team_detail.dart';
// import 'package:untitled2/pages/timekeeppage.dart';
// import 'package:untitled2/pages/login.dart';
import 'package:url_strategy/url_strategy.dart';
import 'auth/authentical.dart';
import 'controller/homeController.dart';

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
          // GetPage(name: '/homepage', page: () => HomePage()),
          GetPage(name: '/loginpage', page: () => LoginPage()),
          // GetPage(name: '/forgotpage', page: () => ForgotPage()),
          // GetPage(name: '/timekeeppage', page: () => TimekeepPage()),
          // GetPage(name: '/schedulepage', page: () => SchedulePage()),
          // GetPage(name: '/distancepage', page: () => DistancePage()),
          // GetPage(name: '/findOfficepage', page: () => FindOfficePage()),
          // GetPage(name: '/findOffice-page', page: () => DetailOffice()),
          // GetPage(name: '/detailuser', page: () => DetailUser()),
          // GetPage(name: '/permissionssettings', page: () => PermissionssettingPage()),
          // GetPage(name: '/driverinfo', page: () => DriverInfo()),
          // GetPage(name: '/driverinfodetail', page: () => DriverInfoDetail()),
          // GetPage(name: '/screencheckteam', page: () => ScreenCheckTeam()),
          // GetPage(name: '/screencheckteamdetail', page: () => ScreenCheckTeamDetail()),
        ],
        home: SafeArea(
            child: LoadingPages()
        ),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false
    );
  }
}