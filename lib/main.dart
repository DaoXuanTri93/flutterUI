import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/pages/officemasterdetails.dart';
import 'package:login_app/pages/stamping_approval_details.dart';
import 'package:login_app/pages/stamping_approval_screen.dart';
import 'package:login_app/pages/web/driver_infor_details.dart';
import 'package:login_app/pages/forgotpage.dart';
import 'package:login_app/pages/homepages.dart';
import 'package:login_app/pages/loadingpage.dart';
import 'package:login_app/pages/loginpage.dart';
import 'package:login_app/pages/missionpage.dart';
import 'package:login_app/pages/schedulepage.dart';
import 'package:login_app/pages/timekeepingpage.dart';
import 'package:login_app/pages/web/change_password_web.dart';
import 'package:login_app/pages/web/driver_infor.dart';
import 'package:login_app/pages/web/screen_check_team.dart';
import 'package:login_app/pages/upload_image_new.dart';
import 'package:login_app/pages/web/screen_check_team_detail.dart';
import 'package:url_strategy/url_strategy.dart';
import 'pages/officemastersearch.dart';
import 'package:login_app/global-variable/globals.dart' as globals;
import 'package:login_app/pages/limit_setting.dart';
import 'package:login_app/pages/user_master_details.dart';
import 'package:login_app/pages/user_master_search.dart';
import 'pages/web/dashboard/narbargation.dart';
import 'pages/web/loginpageweb.dart';
import 'package:login_app/auth/cookie_manager.dart' as cookie;

import 'pages/web/screen_check_mission.dart';
void main() async {
  await GetStorage.init();
  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    easyLoadingInit();
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
          GetPage(name: '/screenCheckTeamDetail',page: () => ScreenCheckTeamDetail()),
          GetPage(name: '/loginPageWeb',page: () => LoginPageWeb()),
          GetPage(name: '/officemastersearch',page: () => OfficeMasterSearch()),
          GetPage(name: '/officedetails',page: () => OfficeDetails()),
          GetPage(name: '/changePassword',page: () => ChangePassword()),
          GetPage(name: '/screenCheckMission',page: () => ScreenCheckMission()),
          GetPage(name: '/navigationBarDemo',page: () => NavigationBarDemo1()),
          GetPage(
              name: '/driver-infor-detail',
              page: () => DriverInforDetails()),
          GetPage(
              name: '/driver-infor',
              page: () => DriverInforSearch()),
          GetPage(name: '/search-users', page: () => UserMasterSearch()),
          GetPage(name: '/users-details', page: () => UserMasterDetails()),
          GetPage(name: '/limit-setting', page: () => LimitSetting()),
          GetPage(name: '/stamping-approval-screen', page: () => StampingApprovalScreen()),
          GetPage(name: '/stamping-approval-detail', page: () => StampingApprovalDetail()),
        ],

        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false);
  }
  void easyLoadingInit(){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 3000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.black
      ..indicatorSize = 60.0
      ..backgroundColor = Colors.green.withOpacity(0)
      ..boxShadow = [BoxShadow(color: Colors.red.withOpacity(0))]
      ..textColor = Colors.black
      ..maskColor = Colors.black54.withOpacity(0.3)
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}


