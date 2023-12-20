import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_app/pages/loadingpage.dart';
import 'package:login_app/pages/loginpage.dart';
import 'package:login_app/pages/user_master_details.dart';
import 'package:login_app/pages/user_master_search.dart';
import 'package:url_strategy/url_strategy.dart';
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
          GetPage(name: '/loginpage', page: () => LoginPage()),
          GetPage(name: '/search-users', page: () => UserMasterSearch()),
          GetPage(name: '/users-details', page: () => UserMasterDetails()),
        ],
        home: SafeArea(
            child: UserMasterSearch()
        ),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false
    );
  }
}